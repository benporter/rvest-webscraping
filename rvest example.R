install.packages("rvest")

library(rvest)

demo(package = "rvest")
demo(package = "rvest",topic = "tripadvisor")

locations_page <- read_html("http://www.secondharvestmetrolina.org/agencies/Get-Food-Assistance")

# method 1:  this one has the phone number, but the text is messy
locations_page %>% 
  html_nodes("table") %>% 
  .[[1]] %>%
  html_table() %>% 
  head()

# method 2: extract each column individually, then assemble

one_example <- locations_page %>% 
  html_nodes(".xmp-location-listing") %>%
  .[1] 

as.character(one_example)

title <- locations_page %>% 
  html_nodes(".xmp-location-listing") %>% 
  html_attr("data-title") 

latitude <- locations_page %>% 
  html_nodes(".xmp-location-listing") %>% 
  html_attr("data-latitude") 

longitude <- locations_page %>% 
  html_nodes(".xmp-location-listing") %>% 
  html_attr("data-longitude") 

description <- locations_page %>% 
  html_nodes(".xmp-location-listing") %>% 
  html_attr("data-description") 

id <- locations_page %>% 
  html_nodes(".xmp-location-listing") %>% 
  html_attr("data-id") 

# assemble the parts
df <- data.frame(title,latitude,longitude,description,id)
df


# the xpath method
locations_page %>% 
  html_nodes(xpath='//*[contains(concat( " ", @class, " " ), concat( " ", "findLoc", " " ))] | //td') %>% 
  html_text() %>% 
  head()

