library(rvest)
library(tidyverse)

index_mundi <- read_html('https://www.indexmundi.com/map/?v=143&r=eu&l=en') %>% 
  html_nodes(xpath ='//*[@id="gvDataCountry"]') %>% 
  html_table()

mundi <- as.data.frame(index_mundi)

debt <- rename(mundi,
               debt_share_on_gdp = Public.debt....of.GDP.,
               country = Country,
               year = Year)
debt_filtered <- debt[
  debt$country == "Italy" |
    debt$country == "Germany" |
    debt$country == "Spain" |
    debt$country == "United Kingdom" |
    debt$country == "Sweden", ]
debt_names <- c("ITA", "ESP", "GBR", "DEU", "SWE") 

debt_filtered$country <- debt_names

debt_filtered <- subset(debt_filtered, select = -c(year))


