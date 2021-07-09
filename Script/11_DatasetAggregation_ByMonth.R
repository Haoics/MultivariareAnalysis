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

#Aggregate stringency by month----
#  Convert to date if not already
string$Day <- as.Date(string$Day)

string <- string[string$Day > as_date("2020-03-01"), ]

#  Get months
string$month <- months(string$Day)
string$month <- format(string$Day, format = "%m")

#  Get years
string$year <- format(string$Day,format="%y")
#  Aggregate 'X2' on months and year and get mean

string2 <- select(string, Code, Day, month, year, stringency_index)
string3 <- string2 %>%
  group_by(month, year, Code) %>%
  summarise(string_mean=(mean(stringency_index)))

string3 <- arrange(string3, group =  Code)
#Aggregate Incidence by month-----
#convert date
incidence$data <- as.Date(incidence$date)
incidence$month <- months(incidence$date)
incidence$month <- format(incidence$date,format="%m")
incidence$year <- format(incidence$date,format="%y")

incidence_monthly <- incidence %>% 
  group_by(month, year, iso_code) %>% 
  summarise(incidence_mean = (mean(inc_index)))

incidence_monthly <- arrange(incidence_monthly, group = iso_code)

incidence_monthly[26,] <- NA
incidence_monthly[202,] <- NA
incidence_monthly[346,] <- NA
incidence_monthly[362,] <- NA
incidence_monthly <- drop_na(incidence_monthly)

string3 <- rename(string3,
                  iso_code = Code)

step1 <- merge(string3, incidence_monthly, id = iso_code)

step2 <- arrange(step1, iso_code)

datax16 <- data_main[rep(seq_len(nrow(data_main)), each = 16), ]
datax16 <- arrange(datax16, group = country_name_short)

datax16[17, ] <- NA
datax16[203, ] <- NA
datax16[346, ] <- NA
datax16[362, ] <- NA
datax16 <- drop_na(datax16)

datax16 <- rename(datax16, 
                    iso_code = country_name_short)

step3 <- cbind(step2, datax16)
step3 <- step3[-c(6, 12:17)]




