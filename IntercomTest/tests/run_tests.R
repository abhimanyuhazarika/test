install.packages("testthat")
library(testthat) 
source("U:/IntercomTest/userDistance.R")

test_results <- test_dir("U:/IntercomTest/tests", reporter="summary")
test_results
