string <- rio::import(here::here("Dataset/", "stringency.csv"))

string <- string[
  string$Code == "ITA" |
    string$Code == "DEU" |
    string$Code == "ESP" |
    string$Code == "GBR" |
    string$Code == "SWE" |
    string$Code == "BEL" |
    string$Code == "BGR" |
    string$Code == "CYP" |
    string$Code == "CZE" |
    string$Code == "DNK" |
    string$Code == "EST" |
    string$Code == "FRA" |
    string$Code == "GRC" |
    string$Code == "HRV" |
    string$Code == "HUN" |
    string$Code == "IRL" |
    string$Code == "LTU" |
    string$Code == "LUX" |
    string$Code == "MLT" |
    string$Code == "NLD" |
    string$Code == "POL" |
    string$Code == "PRT" |
    string$Code == "ROU" |
    string$Code == "SVK" |
    string$Code == "SVN" , ]

#Aggregate dataset by month----
#  Convert to date if not already
string$Day <- as.Date(string$Day)

#  Get months
string$month <- months(string$Day)

#  Get years
string$year <- format(string$Day,format="%y")
#  Aggregate 'X2' on months and year and get mean

string2 <- select(string, Code, Day, month, year, stringency_index)
string3 <- string2 %>%
  group_by(month, year, Code) %>%
  summarise(string_mean=(mean(stringency_index)))

