library(rvest)
library(tidyverse)
library(httr)
browseURL("https://beppegrillo.it/category/archivio/2016/")

# .td_module_10 .td-module-title

#create a function download_politely-----

download_politely <- function(from_url, to_html, my_email, my_agent = R.Version()$version.string) {
  
  require(httr)
  
  # Check that arguments are inputted as expected:
  stopifnot(is.character(from_url))
  stopifnot(is.character(to_html))
  stopifnot(is.character(my_email))
  
  # GET politely
  grillo_16 <- httr::GET(url = from_url, 
                         add_headers(
                           From = my_email, 
                           `User-Agent` = R.Version()$version.string
                         )
  )
  # If status == 200, extract content and save to a file:
  if (httr::http_status(grillo_16)$message == "Success: (200) OK") {
    bin <- content(grillo_16, as = "raw")
    writeBin(object = bin, con = to_html)
  } else {
    cat("Houston, we have a problem!")
  }
}

#create a character vector with the links of the 47 pages-----
require(stringr)
link <- str_c("https://beppegrillo.it/category/archivio/2016/page/", 1:47)


#download the links of the 47 pages into a folder "grillo_linkpages" ------
dir.create("grillo_linkpages")

for (i in seq_along(link)) {
  cat(i, " ")
  
  download_politely(from_url = link[i], 
                    to_html = here::here("grillo_linkpages", str_c("page_",i,".html")), 
                    my_email = "francescamartinoli@yahoo.com")
  
  Sys.sleep(1)
}

#download the posts of every pages-----

to_scrape <- list.files(here::here("grillo_linkpages"), full.names = TRUE)   # get the list of pages 
all_posts <- vector(mode = "list", length = length(to_scrape))    # empty container where to place the posts

# Loop over the pages of each season and scrape the titles
for (i in seq_along(all_posts)){
  all_posts[[i]] <- read_html(to_scrape[i]) %>% 
    html_elements(css = ".td_module_10 .td-module-title") %>% 
    html_text(trim = TRUE)
}

#così abbiamo preso solo i titoli e non i link !!!!
str(all_posts)
all_posts[[1]]    # posts from page 1

##### tentaivo 1: questo tentativo non funziona ###### -----
#dir.create("grillo_linkpost")

#post <- unlist(all_posts)
#
#for (i in seq_along(post)) {
#  cat(i, " ")
#  
#  download_politely(from_url = post[i], 
#                    to_html = here::here("grillo_linkpost", str_c("page_",i,".html")), 
#                    my_email = "francescamartinoli@yahoo.com")
#  
#  Sys.sleep(1)
#}
#
#

#tentativo 2 -----
to_scrape <- list.files(here::here("grillo_linkpages"), full.names = TRUE)   # get the list of pages 
all_posts <- vector(mode = "list", length = length(to_scrape))    # empty container where to place the posts

##extract all the links----

for (i in seq_along(all_posts)){
  all_posts[[i]] <- XML::getHTMLLinks(to_scrape[i], externalOnly = T)
}
all_posts1 <- unlist(all_posts[1])
str_extract_all(all_posts1, pattern = "^https://beppegrillo\\.it/")
