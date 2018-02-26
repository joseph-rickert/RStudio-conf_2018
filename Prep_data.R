library(tidyverse)
library(stringr)
#pdb <- tools:::CRAN_package_db()
str(pdb, max.levels = 1)
dim(pdb)
names(pdb)

pkgs <- pdb[, c(1,4,5,17,60,61)]
names(pkgs)
names(pkgs) <- c("Package","Dep","Imp","Aut","RD","RI")
head(pkgs)

DepL <- list()
ImpL <- list()
AutL <- list()
RDL <- list()
RIL <- list()
DepImpL <- list()
RDRIL  <- list()


for(i in 1:length(pkgs$Package)){
  DepL[[i]] <- na.omit(pkgs[pkgs$Package == pkgs$Package[[i]], ][["Dep"]] %>% strsplit(","))
  ImpL[[i]] <- na.omit(pkgs[pkgs$Package == pkgs$Package[[i]], ][["Imp"]] %>% strsplit(","))
  AutL[[i]] <- na.omit(pkgs[pkgs$Package == pkgs$Package[[i]], ][["Aut"]] %>% strsplit(","))
  RDL[[i]]  <- na.omit(pkgs[pkgs$Package == pkgs$Package[[i]], ][["RD"]] %>% strsplit(","))
  RIL[[i]]  <- na.omit(pkgs[pkgs$Package == pkgs$Package[[i]], ][["RI"]] %>% strsplit(","))
  DepImpL[[i]] <- na.omit(union(unlist(DepL[[i]]), unlist(ImpL[[i]])))
  RDRIL[[i]] <- na.omit(union(unlist(RDL[[i]]), unlist(RIL[[i]])))
}


################
num_Dep <- vector()
num_Imp <- vector()
num_Aut <- vector()
num_RD <- vector()
num_RI <- vector()
num_DepImp <- vector()
num_RDRI <- vector()


for(i in 1:length(pkgs$Package)){
  num_Dep[i] <- length(unlist(DepL[[i]]))
  num_Imp[i] <- length(unlist(ImpL[[i]]))
  num_Aut[i] <- length(unlist(AutL[[i]]))
  num_RD[i]  <- length(unlist(RDL[[i]]))
  num_RI[i]  <- length(unlist(RIL[[i]]))
  num_DepImp[i] <- length(unlist(DepImpL[[i]]))
  num_RDRI[i]   <- length(unlist(RDRIL[[i]]))
}

dF <- data.frame(pkgs$Package, num_Aut, num_Dep,num_Imp,num_DepImp,num_RD,num_RI,num_RDRI)

dFs <- arrange(dF,desc((num_RDRI)))


library(ggplot2)
p <- ggplot(dFs, aes(num_RDRI))
p + geom_histogram() + xlim(0,50) + ylim(0,500)

####################################
# Some Debugging

pdb[pdb$Package=="Matrix",c("Depends","Imports")]

# Depends                                        Imports
# 5815  R (>= 3.0.1) methods, graphics, grid, stats, utils, lattice
# 12014   R (>= 3.5) methods, graphics, grid, stats, utils, lattice

RDL[5815]

# dF[5815]
# Matrix
# 28
# 2
# 12
# 8
# 516 This is a list of 2 (2 * 258) Why?
# 820 This is a list of 2 (2 * 410)
# 666 This is 258 + 410 It is what it is supposed to be the union of RDL and RIL

x <- list()
rd <- list()
ri <- list()

for(i in seq(pkgs$Package)){
  rd[[i]]  <- na.omit(pkgs[pkgs$Package == pkgs$Package[[i]], ][["RD"]] %>% strsplit(","))
  ri[[i]]  <- na.omit(pkgs[pkgs$Package == pkgs$Package[[i]], ][["RI"]] %>% strsplit(","))
  x[[i]] <- na.omit(union(unlist(RDL[[i]]), unlist(RIL[[i]])))
}
  
  






