library(tidyverse)
library(stringr)
#pdb <- tools:::CRAN_package_db()
load(file="pdb.RDA")

pkgs <- pdb[, c(1,4,5,17,60,61)]
names(pkgs)
names(pkgs) <- c("Package","Dep","Imp","Aut","RD","RI")
head(pkgs)

######################################
# Clean up Authors
# Remove all text between two brackets
# http://bit.ly/2mE7TNJ
clean <- function(x){
  gsub("\\[[^]]*]", "",x)
}

# Remove line breaks
# http://bit.ly/2B0n4VS

clean2 <- function(x){
  gsub("[\r\n]", "", x)
}

x <- lapply(pkgs$Aut,clean)
xx <- lapply(x,clean2)
########################################

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
  AutL[[i]] <- unlist(xx[[i]] %>% strsplit(","))
  RDL[[i]]  <- unlist(pkgs$RD[[i]] %>% strsplit(","))
  RIL[[i]]  <- unlist(pkgs$RI[[i]] %>% strsplit(","))
  DepImpL[[i]] <- na.omit(union(unlist(DepL[[i]]), unlist(ImpL[[i]])))
  RDRIL[[i]] <- na.omit(union(unlist(RDL[[i]]), unlist(RIL[[i]])))
  }

dL <- list(DepL,ImpL,AutL,RDL,RIL,DepImpL,RDRIL)

################
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

mean(dF$num_RDRI) #3.085191
median(dF$num_RDRI) # 0
quantile(dF$num_RDRI, probs = seq(.5,1,.1))
#50%  60%  70%  80%  90% 100% 
# 0    0    0    1    2 1220 

dFs <- arrange(dF,desc((num_RDRI)))
names(dFs) <- c("Package", "Aut", "Dep", "Imp", "RD", "RI", "DepImp", "RDRI")
dFsu <- filter(dFs,unique(Package))

library(ggplot2)
p <- ggplot(dFs, aes(num_RDRI))
p + geom_histogram() + xlim(0,50) + ylim(0,500)

p1 <- ggplot(dFs, aes(num_Aut))
p1 + geom_histogram(bins=25) + xlim(0,10)

dFs400 <- dFs %>% select(pkgs.Package,num_RDRI) %>% filter(num_RDRI > 400)
names(dFs400) <-c("Package","RDRI")
  