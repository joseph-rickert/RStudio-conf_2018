



What Makes a Great
========================================================

![](R-Logo.png)
    
# Package?

Joseph Rickert     
February 3, 2018     






CRAN: The Home of Hidden Treasures
========================================================

12,000 + Packages

![](warehouse2.png)




Disenchantment with CRAN?
========================================================
>"There is no benefit to having a package on CRAN"  
     
>Richard McElreath in "Statistical Rethinking"     

>![Source: Shutterstock](Questionmark.png)


GitHub is gaining ground
=========================================================
METACRAN
![](metacran.png)  


How many CRAN Packages are valuable?
========================================================
![](taskviews.png)   

***   

At least about 1/4!
* 35 Task Views
* All curated by experts
* Containing 2,960 packages 

I think most of what is on CRAN is extremely valuable!


CRAN == Statistical Knowledge
==============================================================
CRAN is the worlds largest most complete repository of statistical computing knowledge.

![](glm.png)

Types of R Packages
=========================================================
By application domain:
* Computational Methods
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

Professional Packages
=======================================================
e.g. [clindr](https://CRAN.R-project.org/package=clinDR)   

![](clindr.png)   

***

* References behind paywall
* No vignette
* No README
* Looks like quite a bit of work went into it
   * Numerous functions
   * Parallel execution


Good R Packages:
========================================================
* Do something that people other than the author might consider useful   
* Offer enough functionality to make it worth remembering   
* Are well documented with both:   
   + Complete reference manuals that included references
   + README and NEWS files
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


My Picks for the R Package Hall of Fame
=========================================================

Package   | Year| Description                         | Author
----------|-----|-------------------------------------|-----------------    
caret     | 2007| A framework for predictive modeling | Kuhn et al.
bigmemory | 2008| Matrices in memory mapped files     | Kane ot al.
data.table| 2006| Fast, big data queries              | Dowle et al.
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
Matrix    | 2000| Matrix Algebra                      | Bates et al.
Rcpp      | 2008| R interface to C++                  | Eddelbuettel et al.
rmarkdown | 2014| Reproducible research               | Allaire et al.
shiny     | 2012| Web apps & reactive programming     | Chang et al.
sp        | 2005| Spatial statistics                  | Pebesma et al.
XML       | 2000| Work with XML & HTML                | Temple Lang et al.
zoo       | 2004| Time Series                         | Zeileis et al.

Contributions of Hall of Fame Packages
========================================================
* To the R Language itself: data.table, XML, bigmemory
* To Statistics: lme4, sp, glmnet, Hmisc
* To Statistical computing: foreach, Rcpp, Matrix, MASS, zoo
* To the display of information: ggplot2
* To machine learning: caret, e1071, forecast
* To reproducible research and the "science of data science": dplyr, knitr, rmarkdown, shiny

> Wickham . . .making tidy data tools available . . .may have more impact on today’s practice of data analysis than many highly regarded theoretical statistics articles.
[Donoho (20i7) *50 Years of Data Science](http://www.tandfonline.com/doi/full/10.1080/10618600.2017.1384734)

Some Simple Package Stats
========================================================

```r
pdb <- tools:::CRAN_package_db()
dim(pdb)
```

```
[1] 12118    65
```



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


Collaboration
=========================================================
Author quantiles

```
  0%  25%  50%  75% 100% 
   1    1    1    3   97 
```

<img src="JBR_Talk-figure/unnamed-chunk-7-1.png" title="plot of chunk unnamed-chunk-7" alt="plot of chunk unnamed-chunk-7" style="display: block; margin: auto;" />


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
        XML   1   3   0  52  169      3  221
        zoo   5   2   4  62  150      6  212
       lme4   9   4  10  47   98     14  145
      Hmisc   2   4  15  43  100     19  143
      knitr  77   1   8  10  113      9  123
      e1071   7   0   6  24   88      6  112
      caret  16   3  12   9   51     15   60
   forecast   5   1  13  22   38     14   60
  bigmemory   4   4   1  12   16      5   28
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






