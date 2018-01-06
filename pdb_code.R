pdb <- tools:::CRAN_package_db()
str(pdb, max.levels = 1)

library(dplyr)
pdb[pdb$Package == "Hmisc", ] %>% View()
names(pdb)
pdb[pdb$Package == "Hmisc", c("Package", "Reverse depends", "Reverse imports")]
x <- pdb[pdb$Package == "Hmisc", ][["Reverse imports"]] %>% strsplit(",")

save(pdb, file="pdb.RDA")
