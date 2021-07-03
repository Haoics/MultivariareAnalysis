##ICU * 100000 HAB.
library(rvest)

icu <- read_html('https://tradingeconomics.com/country-list/icu-beds') %>% 
  html_nodes(xpath ='//*[@id="ctl00_ContentPlaceHolder1_ctl00_UpdatePanel1"]/div/div[2]/table') %>% 
  html_table()

icu2 <- as.data.frame(icu)

icu3 <- icu2[
  icu2$Country == "Italy" |
    icu2$Country == "Germany" |
    icu2$Country == "Spain" |
    icu2$Country == "United Kingdom" |
    icu2$Country == "Sweden" |
    icu2$Country == "Belgium" |
    icu2$Country == "Bulgaria" |
    icu2$Country == "Cyprus" |
    icu2$Country == "Czech Republic" |
    icu2$Country == "Denmark" |
    icu2$Country == "Estonia" |
    icu2$Country == "France" |
    icu2$Country == "Greece" |
    icu2$Country == "Croatia" |
    icu2$Country == "Hungary" |
    icu2$Country == "Ireland" |
    icu2$Country == "Lithuania" |
    icu2$Country == "Luxembourg" |
    icu2$Country == "Malta" |
    icu2$Country == "Netherlands" |
    icu2$Country == "Poland" |
    icu2$Country == "Portugal" |
    icu2$Country == "Romania" |
    icu2$Country == "Slovakia" |
    icu2$Country == "Slovenia" , ]

icu4 <- rename(icu3,
               country_name = Country,
               ICU = Last)

icu4 <- select(icu4, country_name, ICU)











