library(circlize)
library(showtext)
library(dplyr)
library(readr)

font_add_google("Nanum gothic")

# Sourcing functions 
#getwd()
workinghome = "/home/rstudio/anari-github/gwcho-circlize/"
if(!exists("gen_mat", mode="function")) source(paste0(workinghome,"functions.R"))

wrap_oneside_chord("test_data.csv", c("프리랜서"), alpha_h=0.7, alpha_l=0.07, save_pdf=F) 
wrap_oneside_chord("test_data.csv", c("공학", "인문사회"), alpha_h=0.7, alpha_l=0.07, save_pdf=T) 

