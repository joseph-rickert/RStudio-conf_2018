# This script is a irst look at using the CRAN_package_db() function 
# in the tools package
library(dplyr)
pdb <- tools:::CRAN_package_db()
str(pdb, max.levels = 1)

pdb[pdb$Package == "Hmisc", ] %>% View()
names(pdb)

pdb[pdb$Package == "Hmisc", c("Package", "Reverse depends", "Reverse imports")]
x <- pdb[pdb$Package == "Hmisc", ][["Reverse imports"]] %>% strsplit(",")
save(pdb, file="pdb.RDA")
