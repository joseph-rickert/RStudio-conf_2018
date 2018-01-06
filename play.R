
library(tidyverse)
library(stringr)
pdb <- tools:::CRAN_package_db()
str(pdb, max.levels = 1)
dim(pdb)
names(pdb)
class(pdb)


pkgs <- pdb[, c(1,4,5,17,60,61)]
names(pkgs)
names(pkgs) <- c("Package","Dep","Imp","Aut","RD","RI")
head(pkgs)

Dep <- list()

x <- pdb[pdb$Package == "Hmisc", ][["Reverse imports"]] %>% strsplit(",")

x <- pkgs[pkgs$Package == "A3", ][["Dep"]] %>% strsplit(",")
x
class(x)
length(x)
x[[1]][1]
x[[1]][2]
x[[1]][3]
length(x[[1]])


y <- pkgs[pkgs$Package == pkgs$Package[[1]], ][["RI"]] %>% strsplit(",")
y

length(pkgs$Package)

DepL <- list()
ImpL <- list()
AutL <- list()
RDL <- list()
RIL <- list()
DepImpL <- list()
RDRIL  <- list()
for(i in 1:6){
  DepL[[i]] <- na.omit(pkgs[pkgs$Package == pkgs$Package[[i]], ][["Dep"]] %>% strsplit(","))
  ImpL[[i]] <- na.omit(pkgs[pkgs$Package == pkgs$Package[[i]], ][["Imp"]] %>% strsplit(","))
  AutL[[i]] <- na.omit(pkgs[pkgs$Package == pkgs$Package[[i]], ][["Aut"]] %>% strsplit(","))
  RDL[[i]]  <- na.omit(pkgs[pkgs$Package == pkgs$Package[[i]], ][["RD"]] %>% strsplit(","))
  RIL[[i]]  <- na.omit(pkgs[pkgs$Package == pkgs$Package[[i]], ][["RI"]] %>% strsplit(","))
  DepImpL[[i]] <- na.omit(union(unlist(DepL[[i]]), unlist(ImpL[[i]])))
  RDRIL[[i]] <- na.omit(union(unlist(RDL[[i]]), unlist(RIL[[i]])))
}

####################

DIL <- list()
for(i in 1:6){
  DIL[[i]] <- union(unlist(DepL[[i]]), unlist(ImpL[[i]]))
}

DIL

DepL[[1]]
length(DepL[[1]])
x <- unlist(DepL[[1]])
x
length(x)
str(x)


Dep <- vector()
Dep[1] <- length(x)
Dep[1]

################
num_Dep <- vector()
num_Imp <- vector()
num_Aut <- vector()
num_RD <- vector()
num_RI <- vector()
num_DepImp <- vector()
num_RDRI <- vector()

num_Dep[1] <- length(unlist(DepL[[1]]))
num_Dep[1]

for(i in 1:6){
  num_Dep[i] <- length(unlist(DepL[[i]]))
  num_Imp[i] <- length(unlist(ImpL[[i]]))
  num_Aut[i] <- length(unlist(AutL[[i]]))
  num_RD[i]  <- length(unlist(RDL[[i]]))
  num_RI[i]  <- length(unlist(RIL[[i]]))
  num_DepImp[i] <- length(unlist(DepImpL[[i]]))
  num_RDRI[i]   <- length(unlist(RDRIL[[i]]))
}

dF <- data.frame(pkgs$Package[1:6], num_Aut, num_Dep,num_Imp,num_DepImp,num_RD,num_RI,num_RDRI)

