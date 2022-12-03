
library(stringr)
library(dplyr)

#in order to match the links i use the function str_view_all

str_view_all(links, pattern = "^https://beppegrillo\\.it/.+")

str_view_all(links, pattern = "https://beppegrillo\\.it/grilloteca")
  
#extract all the links of the beppe grillo blog, 
#and then put it in a table called "links_bgrillo"

links_bgrillo_list <- str_extract_all(
  links, 
  pattern = "^https://beppegrillo\\.it/.+")

links_unl <- unlist(links_bgrillo_list)
links_bgrillo <- as.data.frame(links_unl)


links_unl == links_bgrillo



  

