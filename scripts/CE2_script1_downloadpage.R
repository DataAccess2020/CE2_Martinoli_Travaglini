library(RCurl)
url <- "https://beppegrillo.it/un-mare-di-plastica-ci-sommergera/"


resp <- RCurl::getURL(url = url, httpheader = c(from = "francescamartinoli@yahoo.com", 'User-Agent' = R.Version()$version.string))

#using the package RCurl (function getURL) I downloaded the HTML of the url. 
