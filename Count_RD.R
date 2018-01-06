library(tidyverse)
library(stringr)
#pdb <- tools:::CRAN_package_db()
load(file="pdb.RDA")

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
RDRIL <- list()


for(i in seq(pkgs$Package)){
  DepL[[i]] <- unlist(pkgs$Dep[[i]] %>% strsplit(","))
  ImpL[[i]] <- unlist(pkgs$Imp[[i]] %>% strsplit(","))
  AutL[[i]] <- unlist(pkgs$Aut[[i]] %>% strsplit(","))
  RDL[[i]]  <- unlist(pkgs$RD[[i]] %>% strsplit(","))
  RIL[[i]]  <- unlist(pkgs$RI[[i]] %>% strsplit(","))
  DepImpL[[i]] <- na.omit(union(unlist(DepL[[i]]), unlist(ImpL[[i]])))
  RDRIL[[i]] <- na.omit(union(unlist(RDL[[i]]), unlist(RIL[[i]])))
  }
  
#
dL <- list(DepV,ImpV,AutV,RDV,RIV,DepImpV,RDRIV)

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


library(ggplot2)
p <- ggplot(dFs, aes(num_RDRI))
p + geom_histogram() + xlim(0,50) + ylim(0,500)

dFs400 <- dFs %>% select(pkgs.Package,num_RDRI) %>% filter(num_RDRI > 400)
names(DFs400) <-c("Package","RDRI")
  