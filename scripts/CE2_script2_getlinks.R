library(rvest)
library(tidyverse)

#get all links from the page

links <- rvest::read_html(resp) %>% 
  html_elements(css = "a") %>% 
  html_text()

links

#error: I can see only the title of the links, not the actual link
