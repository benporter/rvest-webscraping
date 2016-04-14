# rvest-webscraping
Code from the 5 min tutorial on webscraping at the Charlotte R Users Group on 3/21/2016

**Resources**

 - Hadley's github repo for examples: <a href="https://github.com/hadley/rvest">https://github.com/hadley/rvest</a>
 - RStudio Blog Post:  <a href="http://blog.rstudio.org/2014/11/24/rvest-easy-web-scraping-with-r/">rvest: easy web scraping with R</a>

**Getting Started**

If the rvest package is not installed already, then run the following.  This only needs to be run once on your machine.

    install.packages("rvest")

Then load the rvest library, which needs to be done every time you spin up R.

    library(rvest)

View the available demos within the rvest package:

    demo(package = "rvest")
    #produces the following list
    Demos in package ‘rvest’:
    tripadvisor                          Scrape review data from tripadvisor
    united                               Scrape mileage details from united.co
    zillow                               Scrape housing info from tripadvisor

Then run one of the demos:

    demo(package = "rvest",topic = "tripadvisor")
    
**Example**:  Scraping an html table from <a href="http://www.secondharvestmetrolina.org/agencies/Get-Food-Assistance">Second Harvest Food Bank</a>

1 - Scrap the "Complete Location Listings" table using the html_table() method.

    locations_page <- read_html("http://www.secondharvestmetrolina.org/agencies/Get-Food-Assistance")
    
    locations_page %>% 
    html_nodes("table") %>% 
    .[[1]] %>%
    html_table() %>% 
    head()

2 - Pull the table that stores the lats and longs, one field at a time using html_attr() method.

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

Assemble each column into a dataframe.

    df <- data.frame(title,latitude,longitude,description,id)
    
3 - Using the xpath method:

    locations_page %>% 
    html_nodes(xpath='//*[contains(concat( " ", @class, " " ), concat( " ", "findLoc", " " ))] | //td') %>% 
    html_text() %>% 
    head()
