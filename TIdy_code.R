
# This script presents alternate methods of obtaining and processing the CRAN package
# metadata used my 2018 RStudio::Conf talk: "What makes a Great R Package?"

library(tidyverse)
library(stringr)

# OBTAIN DATA FROM CRAN
#pdb <- tools:::CRAN_package_db() Last run Jan-31-2018

load(file="pdbJan31.RDA")
pkgs <- pdb[, c(1,4,5,17,60,61)]
names(pkgs) 
names(pkgs) <- c("Package","Dep","Imp","Aut","RD","RI")
head(pkgs)

# for loop method of creating new features that are respectively the union of Dep and
# and Imp, and the union of RD and RI,

for(i in seq_along(pkgs$Package)){
 
  pkgs$DepImp[[i]] <- list(na.omit(union(unlist(pkgs$Dep[[i]]), unlist(pkgs$Imp[[i]]))))
  pkgs$RDRI[[i]] <- list(na.omit(union(unlist(pkgs$RD[[i]]), unlist(pkgs$RI[[i]]))))
}
pkgs$DepImp[[2]]
pkgs$Dep[[2]];pkgs$Imp[[2]]


#################################
# Using mapply() to create the union 
fcn <- function(x,y){
  x <- unlist(x) %>% strsplit(",")
  y <- unlist(y) %>% strsplit(",")
  z <- unlist(na.omit(union(x, y)))
}
pkgs2 <- pkgs

pkgs2 <- mutate(pkgs2,
                DepImp = mapply(fcn,Dep,Imp),
                RDRI = mapply(fcn,RD,RI))

##Bug?
pkgs6 <- mutate(pkgs2,
                DepImp = map2(fcn,Dep,Imp),
                RDRI = map2(fcn,RD,RI))


k <- 1
pkgs2$RDRI[[k]]
ii <- na.omit(pkgs2$RDRI[[k]])
ii
length(pkgs2$RDRI[[k]])
length(ii)
class(pkgs2$RDRI[[k]])


# CLEAN THE AUTHOR'S FIELD
# Function to remove all text between two brackets
# http://bit.ly/2mE7TNJ
clean <- function(x){
  gsub("\\[[^]]*]", "",x)
}

# Function to remove line breaks
# http://bit.ly/2B0n4VS

clean2 <- function(x){
  gsub("[\r\n]", "", x)
}

# Clean Author's field
pkgs$Aut <- pkgs$Aut %>% lapply(clean) %>% lapply(clean2)

# Tidyverse function
pkgs2$Aut <- pkgs$Aut %>% map(clean) %>% map(clean2)
pkgs$Aut[[3]]
pkgs2$Aut[[3]]

##########################################
# Next we need to create the count fields
# This code works but it is very cumbersion.
# The first for loop generates several lists which are combined into a single list
# The second for loop uses the combined list to generate data frame of counts.

# Generate lots of lists
DepL <- list()
ImpL <- list()
AutL <- list()
RDL <- list()
RIL <- list()
DepImpL <- list()
RDRIL <- list()


for(i in seq_along(pkgs$Package)){
  DepL[[i]] <- unlist(pkgs$Dep[[i]] %>% strsplit(","))
  ImpL[[i]] <- unlist(pkgs$Imp[[i]] %>% strsplit(","))
  AutL[[i]] <- unlist(pkgs$Aut[[i]] %>% strsplit(","))
  RDL[[i]]  <- unlist(pkgs$RD[[i]] %>% strsplit(","))
  RIL[[i]]  <- unlist(pkgs$RI[[i]] %>% strsplit(","))
  DepImpL[[i]] <- na.omit(union(unlist(DepL[[i]]), unlist(ImpL[[i]])))
  RDRIL[[i]] <- na.omit(union(unlist(RDL[[i]]), unlist(RIL[[i]])))
}

dL <- list(DepL,ImpL,AutL,RDL,RIL,DepImpL,RDRIL)

# Build the data frame of counts
num_Dep <- vector()
num_Imp <- vector()
num_Aut <- vector()
num_RD <- vector()
num_RI <- vector()
num_DepImp <- vector()
num_RDRI <- vector()


for(i in seq(pkgs$Package)){
  num_Dep[i] <- length(na.omit(unlist(DepL[[i]])))
  num_Imp[i] <- length(na.omit(unlist(ImpL[[i]])))
  num_Aut[i] <- length(na.omit(unlist(AutL[[i]])))
  num_RD[i]  <- length(na.omit(unlist(RDL[[i]])))
  num_RI[i]  <- length(na.omit(unlist(RIL[[i]])))
  num_DepImp[i] <- length(na.omit(unlist(DepImpL[[i]])))
  num_RDRI[i] <- length(na.omit(unlist(RDRIL[[i]])))
}


dF <- data.frame(pkgs$Package, num_Aut, num_Dep,num_Imp,num_RD,num_RI,num_DepImp,num_RDRI)
names(dF) <- c("Package", "Aut", "Dep", "Imp", "RD", "RI", "DepImp", "RDRI")
head(dF)


#################################             
### This tidy code from Edgar Ruiz is what we want to get to.
# The problem is that the DepImp and RDRI variables need to be added.
                   
pkg_counts <- seq_len(nrow(pkgs2)) %>%
  map_df(~{
    pkgs2[.x, ] %>%
      select(-Package) %>%
      map_df(~ifelse(is.na(.x), 0, length(str_split(.x, ",")[[1]]))) %>%
      mutate(Package = pkgs2$Package[.x])
  }) %>%
  select(Package,Aut, Dep, Imp, RD, RI, DepImp, RDRI)
            
k <- 3     
pkgs$RDRI[[k]]
pkgs$RD[[k]];pkgs$RI[[k]]

pkgs2$RDRI[[k]]
pkgs2$RD[[k]];pkgs2$RI[[k]]
##########
length(pkgs$RDRI[[k]])
length(pkgs2$RDRI[[k]])
###############
head(dF)
head(pkg_counts)

##################

# Some Debugging

rm_na <- function(x){
  list(na.omit(unlist(x)))
}

pkgs3 <- pkgs2 %>% select(Package,Aut,Dep,Imp,RD,RI)
pkgs4 <- pkgs2 %>% select(DepImp,RDRI)

df3 <- seq_len(nrow(pkgs3)) %>%
  map_df(~{
    pkgs3[.x, ] %>%
      select(-Package) %>%
      map_df(~ifelse(is.na(.x), 0, length(str_split(.x, ",")[[1]]))) %>%
      mutate(Package = pkgs3$Package[.x])
  }) %>%
  select(Package,Aut, Dep, Imp, RD, RI)
head(df3)


df4 <- seq_len(nrow(pkgs4)) %>%
  map_df(~{
    pkgs4[.x, ] %>%
      map_df(~ifelse(is.na(.x), 0, length(rm_na(.x)[[1]])))
  }) %>%
  select(DepImp, RDRI)
head(df4)

dF2 <- cbind(df3,df4)
head(dF2)

x <- pkgs2$RDRI[4]
x
class(x)
length(x)
length(str_split(x, ","))[[1]]



ll <- (ifelse(is.na(x), 0, length(str_split(x, ",")[[1]])))
ll


df5 <- seq_len(nrow(pkgs)) %>%
  map_dfr(~{
    pkgs[.x,] %>%
      select(-Package) %>%
      map_dfr(~ifelse(is.na(.x), 0, length(str_split(.x, ",")[[1]]))) %>%
      mutate(Package = pkgs$Package[.x])
  }) %>%
  select(Package,Aut, Dep, Imp, RD, RI, DepImp, RDRI)

pkgs[1,] %>%
map_df(~ifelse(is.na(pkgs[1,]), 0, str_split(pkgs[1,], ",")[[1]]))
