#scrape the main text ------

library(rvest)
library(stringr)

text_scrape <- list.files(here::here("link_post2016"), full.names = TRUE)


text_post = lapply(text_scrape, function(x) {
  read = read_html(x) %>% 
    html_elements(css = "p") %>% 
    html_text(trim = TRUE)
})

print(text_post[[1]])

text_post_unl <- unlist(text_post)
text_post_t <- tibble(text_post_unl)
text_post_t <- distinct(text_post_t) #ripulito
