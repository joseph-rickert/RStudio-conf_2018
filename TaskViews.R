

# For Task Views on 1/24/18
# TaskViews_Long.csv prepared manually
tv <- read_csv("TaskViews_Long.csv", col_names =TRUE)
dim(tv) #3551    2

unique(tv$Package) %>% length #2960
unique(tv$TaskView) %>% length #35

gp <- c("caret","bigmemory","data.table","e1071","dplyr","foreach","forecast","ggplot2",
        "glimnet","Hmisc","knitr","lme4","Matrix","MASS","markdown","Rcpp","shiny","sp","XML","zoo")


##############
# Count packages in each task view
library(XML)
tvs <- readHTMLTable(tv_web_page,header=FALSE)
str(tvs)
tvs_names <- as.character(unlist(tvs[[1]][1]))
length(tvs_names) #35

task_views <- vector()
for(i in seq_along(1:length(tvs_names))){
  page_name <- paste("https://cran.r-project.org/web/views/",tvs_names[i],".html", sep="")
  web_page <- readLines(page_name)
  temp <- web_page[grep("<li><a",web_page)]
  temp <- temp[grep("</li>",temp)]
  task_views[i] <- temp %>% length
}
task_views


##################
### Get merged list of all packages in all task views

pkg <- "start"
for(i in seq_along(1:length(tvs_names))){
  page_name <- paste("https://cran.r-project.org/web/views/",tvs_names[i],".html", sep="")
  web_page <- readLines(page_name)
  temp <- web_page[grep("<li><a",web_page)]
  temp <- temp[grep("</li>",temp)]
  pkg  <- append(pkg,temp)
}
pkg <- pkg[-1]
length(pkg)
unique_pkg <- unique(pkg)
length(unique_pkg)

##################
#for debugging
# page_name2 <- "https://cran.r-project.org/web/views/ChemPhys.html"
# web_page2 <- readLines(page_name2)
# pkg2  <- web_page2[grep("<li><a",web_page2)]
# pkg2  <- pkg2[grep("</li>",pkg2)]


## Get names of lall packages in task views
# function to strip away all extra characters
get_name <- function(x){
  x1 <- strsplit(x,">")
  x2 <- x1[[1]][3]
  x3 <- strsplit(x2,"<")
  x4 <- x3[[1]][1]
  return(x4)
}


tv_pkgs <- unname(sapply(unique_pkg,get_name))
head(tv_pkgs)

######################################
# Find task views for selected packages

url <- "https://CRAN.R-project.org/package=caret"
w_page <- readLines(url)
task <- w_page[grep("views:",w_page) + 1]

x1 <- strsplit(task,">")
x2 <- x1[[1]][grep("</",x1[[1]])]
x3 <- gsub("</a","",x2)
x4 <- x3[-length(x3)]
x4

get_task_views <- function(x){
  url <- paste("https://CRAN.R-project.org/package=",x,sep="")
  w_page <- readLines(url)
  task <- w_page[grep("views:",w_page) + 1]
  x1 <- strsplit(task,">")
  x2 <- x1[[1]][grep("</",x1[[1]])]
  x3 <- gsub("</a","",x2)
  x4 <- x3[-length(x3)]
  return(x4)
}

get_task_views("zoo")


