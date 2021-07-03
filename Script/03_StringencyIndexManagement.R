library(lubridate)

string <- rio::import(here::here("Dataset/", "stringency.csv"))

string_fil <- string[
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

#Belgium stringency----
string_bel_first <- string_fil[
  string_fil$Day > as_date("2020-03-10")  &
    string_fil$Day < as_date("2020-06-15") &
    string_fil$Code == "BEL",
]

string_bel_second <- string_fil[
  string_fil$Day > as_date("2020-08-01")  &
    string_fil$Day < as_date("2021-01-02") &
    string_fil$Code == "BEL",
]

string_bel_third <- string_fil[
  string_fil$Day > as_date("2021-01-03")  &
    string_fil$Day < as_date("2021-06-28") &
    string_fil$Code == "BEL",
]

#Bulgaria stringency----
string_bul_first <- string_fil[
  string_fil$Day > as_date("2020-03-25")  &
    string_fil$Day < as_date("2020-09-01") &
    string_fil$Code == "BGG",
]

string_bul_second <- string_fil[
  string_fil$Day > as_date("2020-09-01")  &
    string_fil$Day < as_date("2021-01-20") &
    string_fil$Code == "BGR",
]

string_bul_third <- string_fil[
  string_fil$Day > as_date("2021-01-21")  &
    string_fil$Day < as_date("2021-06-28") &
    string_fil$Code == "BGR",
]

#Croazia stringency----
string_HRV_first <- string_fil[
  string_fil$Day > as_date("2020-03-25")  &
    string_fil$Day < as_date("2020-08-07") &
    string_fil$Code == "HRV",
]

string_HRV_second <- string_fil[
  string_fil$Day > as_date("2020-08-07")  &
    string_fil$Day < as_date("2021-02-15") &
    string_fil$Code == "HRV",
]

string_HRV_third <- string_fil[
  string_fil$Day > as_date("2021-02-15")  &
    string_fil$Day < as_date("2021-06-28") &
    string_fil$Code == "HRV",
]

#Denmark stringency----
string_DNK_first <- string_fil[
  string_fil$Day > as_date("2020-03-10")  &
    string_fil$Day < as_date("2020-07-22") &
    string_fil$Code == "DNK",
]

string_DNK_second <- string_fil[
  string_fil$Day > as_date("2020-07-22")  &
    string_fil$Day < as_date("2021-02-17") &
    string_fil$Code == "DNK",
]

string_DNK_third <- string_fil[
  string_fil$Day > as_date("2021-02-17")  &
    string_fil$Day < as_date("2021-06-28") &
    string_fil$Code == "DNK",
]

#Cypro stringency----
string_CYP_first <- string_fil[
  string_fil$Day > as_date("2020-03-14")  &
    string_fil$Day < as_date("2020-09-02") &
    string_fil$Code == "CYP",
]

string_CYP_second <- string_fil[
  string_fil$Day > as_date("2020-09-02")  &
    string_fil$Day < as_date("2021-02-14") &
    string_fil$Code == "CYP",
]

string_CYP_third <- string_fil[
  string_fil$Day > as_date("2021-02-14")  &
    string_fil$Day < as_date("2021-06-17") &
    string_fil$Code == "CYP",
]

#CZE stringency----
#THIRD WAWE HAS TWO PICKS
string_CZE_first <- string_fil[
  string_fil$Day > as_date("2020-03-14")  &
    string_fil$Day < as_date("2020-07-15") &
    string_fil$Code == "CZE",
]

string_CZE_second <- string_fil[
  string_fil$Day > as_date("2020-07-15")  &
    string_fil$Day < as_date("2020-12-08") &
    string_fil$Code == "CZE",
]

string_CZE_third <- string_fil[
  string_fil$Day > as_date("2020-12-08")  &
    string_fil$Day < as_date("2021-06-28") &
    string_fil$Code == "CZE",
]

#EST stringency----
string_EST_first <- string_fil[
  string_fil$Day > as_date("2020-03-14")  &
    string_fil$Day < as_date("2020-06-30") &
    string_fil$Code == "EST",
]

string_EST_second <- string_fil[
  string_fil$Day > as_date("2020-08-25")  &
    string_fil$Day < as_date("2021-02-04") &
    string_fil$Code == "EST",
]

string_CYP_third <- string_fil[
  string_fil$Day > as_date("2021-02-05")  &
    string_fil$Day < as_date("2021-06-28") &
    string_fil$Code == "CYP",
]



