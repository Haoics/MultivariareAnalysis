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
    debt$country == "Sweden" |
    debt$country == "Belgium" |
    debt$country == "Bulgaria" |
    debt$country == "Cyprus" |
    debt$country == "Czech Republic" |
    debt$country == "Denmark" |
    debt$country == "Estonia" |
    debt$country == "France" |
    debt$country == "Greece" |
    debt$country == "Croatia" |
    debt$country == "Hungary" |
    debt$country == "Ireland" |
    debt$country == "Lithuania" |
    debt$country == "Luxembourg" |
    debt$country == "Malta" |
    debt$country == "Netherlands" |
    debt$country == "Portugal" |
    debt$country == "Romania" |
    debt$country == "Slovakia" |
    debt$country == "Slovenia" , ]

 
debt_filtered <- subset(debt_filtered, select = -c(year))

cyp <- c("Cyprus", 96)

debt <- rbind(debt_filtered, cyp)

debt <- rename(debt, 
               country_name = country)


##cleaning env
rm(mundi, index_mundi, debt_filtered, cyp)
