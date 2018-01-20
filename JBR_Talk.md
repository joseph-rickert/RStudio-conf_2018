



What Makes a Great R Package?
========================================================
author: Joseph Rickert
date: February 3, 2018
autosize: true

CRAN: The Home of Hidden Treasures
========================================================

12,000 + Packages

![](warehouse2.png)


Disenchantment?
========================================================
>"There is no benefit to having a package on CRAN"  
     
>Richard McElreath in "Statistical Rethinking"     

>![Source: Shutterstock](Questionmark.png)


GitHub is gaining ground
=========================================================
METACRAN
![](metacran.png)  


CRAN: Statistical Knowledge
==============================================================
CRAN is the largest most complete repository of statistical knowledge.

![](glm.png)

Types of R Packages
=========================================================
By application domain:
* Computational functions
* Data
* Data Science
* Machine Learning
* Science 
* Statistics
* Utilities

***

By intended use:  
* Public  
* Private  
   + Personal   
   + Professional  

Good R Packages:
========================================================
* Do something that people other than the author might consider useful   
* Offer enough functionality to make it worth remembering   
* Are well documented with both:   
   + Complete reference manuals that included scientific references   
   + Thoughtful vignettes   
* Work   
* Are well maintained   

The Best R Packages:
=========================================================
* Are well written, tested and provide helpful messages 
* Have champions who actively promote, explain and teach their use   
* Are likely curated by others (R Task Views)   
* Used by other developers   

Great R Packages:
=========================================================
* Add new functionality and capabilities    
* Develop new infrastructure   
* Improve performance    
* Change the way people think about R   
* Expand the reach of R  
* Do something beautiful


Top 15 most integrated CRAN Packages
========================================================

```
      Package Aut DepImp RDRI
1        Rcpp   7      3 1220
2        MASS   6      6 1142
4     ggplot2   3     11 1126
5       dplyr   5     12  684
6      Matrix  13      7  666
8        plyr   1      2  553
9     stringr   2      3  487
10    mvtnorm   9      3  479
11   magrittr   1      0  432
12   survival   2      7  425
14       httr   2      6  409
15   jsonlite   3      1  409
16         sp   9      8  407
17    lattice   1      6  393
19 data.table   6      2  379
```

Some Simple Stats
========================================================

```
       Aut  Dep  Imp  RD   RI    DepImp RDRI
mean   2.23 1.53 2.81 0.7  2.09  4.35   2.79
sd     2.69 1.58 3.87 7.37 21.25 4.06   27.2
median 1    1    1    0    0     3      0   
```

Reverse Depends and Imports Stats
=========================================================
RDRI quantiles

```
  0%  25%  50%  75% 100% 
   0    0    0    0 1220 
```

<img src="JBR_Talk-figure/unnamed-chunk-4-1.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" style="display: block; margin: auto;" />

Collaboration
=========================================================
Author quantiles

```
  0%  25%  50%  75% 100% 
   1    1    1    3   97 
```

<img src="JBR_Talk-figure/unnamed-chunk-6-1.png" title="plot of chunk unnamed-chunk-6" alt="plot of chunk unnamed-chunk-6" style="display: block; margin: auto;" />

My Picks for the R Package Hall of Fame
=========================================================

Package   | Year| Description                         | Author
----------|-----|-------------------------------------|-----------------    
caret     | 2007| A framework for predictive modeling | Kuhn et al.
data.table| 2006| Fast, big data queries              | Dowel et al.
e1071     | 1999| Machine Learning                    | Meyer et al.
dplyr     | 2014| Tidy data manipulation              | Wickham et al.
foreach   | 2009| Parallel computing                  | Calaway & Weston
forecast  | 2009| Time series forecasting             | Hyndman et al.
ggplot2   | 2007| Plots and Visualizations            | Wickham & Cheng
glimnet   | 2008| lasso, elastic net regularization   | Freidman et al.
Hmisc     | 2003| 157 Misc data analysis & utilities  | Harrell et al.
knitr     | 2012| Literate programming                | Xie et al.
lme4      | 2003| GLM mixed-effects models            | Bates et al.
MASS      | 2009| Fundamental statistical functions   | Ribley et al.
Maatrix   | 2000| Matrix Algebra                      | Bates et al.
Rcpp      | 2008| R interface to C++                  | Eddelbuettel et al.
rmarkdown | 2014| Reproducible research               | Allaire et al.
shiny     | 2012| Web apps & reactive programming     | Chang et al.
sp        | 2005| Spatial statistics                  | Pebesma et al.
zoo       | 2004| Time Series                         | Zeileis et al.

Some Hall of Fame Stats
========================================================

```
    Package Aut Dep Imp  RD   RI DepImp RDRI
       Rcpp   7   1   2 156 1064      3 1220
       MASS   6   5   1 437  706      6 1142
    ggplot2   3   1  10 284  842     11 1126
      dplyr   5   1  11  47  637     12  684
     Matrix  13   1   6 258  410      7  666
         sp   9   2   6 139  268      8  407
 data.table   6   1   1  64  315      2  379
    foreach   3   1   3  79  271      4  350
      shiny  29   2  10  41  236     12  277
        zoo   5   2   4  62  150      6  212
       lme4   9   4  10  47   98     14  145
      Hmisc   2   4  15  43  100     19  143
      knitr  77   1   8  10  113      9  123
      e1071   7   0   6  24   88      6  112
      caret  16   3  12   9   51     15   60
   forecast   5   1  13  22   38     14   60
   markdown  16   1   2   3   19      3   22
```

Alternatives to the "Great" Package
========================================================
Families of intergrated packages
* [ROpenSci](https://ropensci.org/)
* [statnet](http://www.statnet.org/)
* [Tidyverse](https://www.tidyverse.org/)    
![](tidyverse.png)


For more details on authoring R presentations please visit <https://support.rstudio.com/hc/en-us/articles/200486468>.






