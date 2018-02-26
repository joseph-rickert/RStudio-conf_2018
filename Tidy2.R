


# This script presents a viable method of processing the CRAN package
# metadata used my 2018 RStudio::Conf talk: "What makes a Great R Package?"

library(tidyverse)
library(stringr)

# OBTAIN DATA FROM CRAN
#pdb <- tools:::CRAN_package_db() Last run Jan-31-2018

load(file="pdbJan31.RDA")
meta_data <- pdb[, c(1,4,5,17,60,61)]
names(meta_data) <- c("Package","Dep","Imp","Aut","RD","RI")
glimpse(meta_data)

#################################
# Add two  new fields to meta_data: the union of Depends and Imports and 
# the union of Reverse depends and Reverse imports
# Using mapply() to create the union 
fcn <- function(x,y){
  x <- unlist(x) %>% strsplit(",")
  y <- unlist(y) %>% strsplit(",")
  z <- unlist(na.omit(union(x, y)))
}

meta_data <- mutate(meta_data,
                DepImp = mapply(fcn,Dep,Imp),
                RDRI = mapply(fcn,RD,RI))

########################################
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
meta_data$Aut <- meta_data$Aut %>% map(clean) %>% map(clean2)

#################################             
# GET THE COUNT DATA
rm_na <- function(x){
  list(na.omit(unlist(x)))
}

# Process the fields Aut, Dep, Imp, RD, RI
c_dat1 <- seq_len(nrow(meta_data)) %>%
  map_df(~{
    meta_data[.x, ] %>%
      select(-Package,-DepImp,-RDRI) %>%
      map_df(~ifelse(is.na(.x), 0, length(str_split(.x, ",")[[1]]))) %>%
      mutate(Package = meta_data$Package[.x])
  }) %>%
  select(Package,Aut, Dep, Imp, RD, RI)
head(c_dat1)

# Process the fields DepImp RDRI
c_dat2 <- seq_len(nrow(meta_data)) %>%
  map_df(~{
    meta_data[.x, ] %>%
      select(-Package, -Aut, -Dep, -Imp, -RD, -RI) %>%
      map_df(~ifelse(is.na(.x), 0, length(rm_na(.x)[[1]])))
  }) %>%
  select(DepImp, RDRI)
head(c_dat2)

c_dat <- cbind(c_dat1,c_dat2)
head(c_dat)



