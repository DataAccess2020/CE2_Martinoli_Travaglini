library(rvest)


#get all links from the page-----

install.packages("XML")
library(XML)

resp
links <- XML::getHTMLLinks(resp, externalOnly = T)
links

library(tidyverse)
#create a table with all the links extracts----
data <- tibble(links)


# i fix the problem with the function gethtmllinks by xml, insted of use rvest.
