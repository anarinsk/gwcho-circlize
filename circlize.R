library(circlize)
library(showtext)
library(dplyr)

font_add_google("Nanum gothic")

# Sourcing functions 
#getwd()
workinghome = "/home/rstudio/anari-github/gwcho-circlize/"
if(!exists("gen_mat", mode="function")) source(paste0(workinghome,"functions.R"))

mat = gen_mat(test_data)
cdf1 <- make_color_table(test_data, "color_selection.csv")
cdf2 <- gen_occ_alphacolor(cdf1, c("공무원"))
cdf3 <- gen_major_alphacolor(cdf1, c("공학", "자연과학"))

cdf1

gen_oneside_hl <- function(df, elements, name="color_selection.csv"){
  
  cdf1 <- make_color_table(df, "color_selection.csv")
  
  if (elements %in% unique(cdf1$major)) {
    gen_major_alphacolor(cdf1, elements)
  } else {
    gen_occ_alphacolor(cdf1, elements)
  }
  
}

color_df <- gen_oneside_hl(test_data, c("공학"))

plot_hichord(mat, color_df)
save_to_pdf(plot_hichord(mat, color_df))

