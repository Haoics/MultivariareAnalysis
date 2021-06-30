library(lubridate)

string <- rio::import(here::here("Dataset/", "stringency.csv"))

string_fil <- string[string$Code == "ITA" |
                       string$Code == "DEU" |
                       string$Code == "ESP" |
                       string$Code == "GBR" |
                       string$Code == "SWE" , ]


#Italy stringency----
string_ita_first <- string_fil[
    string_fil$Day > as_date("2020-03-03")  &
    string_fil$Day < as_date("2020-06-15") &
    string_fil$Code == "ITA",
]

string_ita_second <- string_fil[
  string_fil$Day > as_date("2020-09-15")  &
    string_fil$Day < as_date("2021-02-19") &
    string_fil$Code == "ITA",
]

string_ita_third <- string_fil[
  string_fil$Day > as_date("2021-02-19")  &
    string_fil$Day < as_date("2021-06-28") &
    string_fil$Code == "ITA",
]

#Germany stringency----
string_de_first <- string_fil[
  string_fil$Day > as_date("2020-03-11")  &
    string_fil$Day < as_date("2020-06-30") &
    string_fil$Code == "DEU",
]

string_de_second <- string_fil[
  string_fil$Day > as_date("2020-09-15")  &
    string_fil$Day < as_date("2021-02-16") &
    string_fil$Code == "DEU",
]

string_de_third <- string_fil[
  string_fil$Day > as_date("2021-02-15")  &
    string_fil$Day < as_date("2021-06-28") &
    string_fil$Code == "DEU",
]

#Spain stringency----
string_esp_first <- string_fil[
  string_fil$Day > as_date("2020-03-10")  &
    string_fil$Day < as_date("2020-06-10") &
    string_fil$Code == "ESP",
]

string_esp_second <- string_fil[
  string_fil$Day > as_date("2020-06-10")  &
    string_fil$Day < as_date("2020-12-10") &
    string_fil$Code == "ESP",
]

string_esp_third <- string_fil[
  string_fil$Day > as_date("2020-12-11")  &
    string_fil$Day < as_date("2021-06-28") &
    string_fil$Code == "ESP",
]

#UK stringency----
string_uk_first <- string_fil[
  string_fil$Day > as_date("2020-03-11")  &
    string_fil$Day < as_date("2020-07-02") &
    string_fil$Code == "GBR",
]

string_uk_second <- string_fil[
  string_fil$Day > as_date("2020-09-03")  &
    string_fil$Day < as_date("2020-12-1") &
    string_fil$Code == "GBR",
]

string_uk_third <- string_fil[
  string_fil$Day > as_date("2020-12-02")  &
    string_fil$Day < as_date("2021-05-15") &
    string_fil$Code == "GBR",
]
#attention to england wawes. say it in report.


#Sweden stringency----
string_sw_first <- string_fil[
  string_fil$Day > as_date("2020-03-08")  &
    string_fil$Day < as_date("2020-08-27") &
    string_fil$Code == "SWE",
]

string_sw_second <- string_fil[
  string_fil$Day > as_date("2020-08-27")  &
    string_fil$Day < as_date("2021-01-29") &
    string_fil$Code == "SWE",
]

string_sw_third <- string_fil[
  string_fil$Day > as_date("2021-01-29")  &
    string_fil$Day < as_date("2021-06-28") &
    string_fil$Code == "SWE",
]
