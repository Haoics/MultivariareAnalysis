#Dataset setup panel-----
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

#View(incidence_monthly)
incidence_monthly[26,] <- NA
incidence_monthly[202,] <- NA
incidence_monthly[330,] <- NA
incidence_monthly[346,] <- NA
incidence_monthly <- drop_na(incidence_monthly)

string3 <- rename(string3,
                  iso_code = Code)

step1 <- merge(string3, incidence_monthly, id = iso_code)

step2 <- arrange(step1, iso_code)

datax16 <- data_main[rep(seq_len(nrow(data_main)), each = 16), ]
datax16 <- arrange(datax16, group = country_name_short)

rownames(datax16) <- 1:384

datax16[17, ] <- NA
datax16[193, ] <- NA
datax16[330, ] <- NA
datax16[362, ] <- NA
datax16 <- drop_na(datax16)

datax16 <- rename(datax16, 
                    iso_code = country_name_short)

step3 <- cbind(step2, datax16)
step3 <- step3[-c(6, 12:17)]
################################################################################
#11A 
#Register changes in the cabinets during time

pgovs <- rio::import(here::here("Dataset/", "cabinet.xlsx"))
party <- rio::import(here::here("Dataset/","party.xlsx"))

#belgium: changes gov in october 2020-----
bel <- pgovs[
  pgovs$country_name_short == "BEL" &
    pgovs$cabinet_name == "De Croo" &
    pgovs$cabinet_party == 1,
]

bel_name <- "De Croo"
bel_2_lr <- weighted.mean(bel$left_right, bel$seats)

belp <- party[
  party$party_name_short == "AGL-Gr" |
    party$party_name_short == "CVP|CD&V" |  
    party$party_name_short == "Ecolo" | 
    party$party_name == "Mouvement Réformateur" | 
    party$party_name == "Parti Socialiste" | 
    party$party_name_short == "PVV|VLD" | 
    party$party_name == "Socialistische Partij" &
    party$country_name_short == "BEL",
]

bel_2_la <- weighted.mean(belp$liberty_authority, bel$seats)
bel_2_sm <- weighted.mean(belp$state_market, bel$seats)
bel_share <- sum(bel$seats)/bel$election_seats_total*100
bel_share <- unique(bel_share)

rownames(step3) <- 1:380

step3[c(1:2, 4,6,8,10), 6] <- bel_name
step3[c(1:2, 4,6,8,10), 8] <- bel_2_lr
step3[c(1:2, 4,6,8,10), 9] <- bel_2_sm
step3[c(1:2, 4,6,8,10), 10] <- bel_2_la
step3[c(1:2, 4,6,8,10), 7] <- bel_share

#croatia: changes gov after election in july 2020-----
hrv <- pgovs[
  pgovs$country_name == "Croatia" &
    pgovs$cabinet_name == "Plenkovic III" &
    pgovs$cabinet_party == 1,
]

hrv[3, 14] <- 5

hrv_name <- "Plenkovic III"
hrv_2_lr <- weighted.mean(hrv$left_right, hrv$seats)

hrvp <- party[
  party$party_name_short == "HDZ" |
    party$party_name_short == "SDSS" &
    party$country_name_short == "HRV" |
    party$party_name_short == "ethnic"  &
    party$country_name_short == "HRV",
]

hrvp[3, 9:11] <- 5

hrv_2_la <- weighted.mean(hrvp$liberty_authority, hrv$seats)
hrv_2_sm <- weighted.mean(hrvp$state_market, hrv$seats)
hrv_share <- sum(hrv$seats)/hrv$election_seats_total*100
hrv_share <- unique(hrv_share)


step3[c(176:177, 179, 181, 183,185:191), 6]<- hrv_name
step3[c(176:177, 179, 181, 183,185:191), 8] <- hrv_2_lr
step3[c(176:177, 179, 181, 183,185:191), 9] <- hrv_2_sm
step3[c(176:177, 179, 181, 183,185:191), 10] <- hrv_2_la
step3[c(176:177, 179, 181, 183,185:191), 7] <- hrv_share

#Italy: renzieee's crisis----
#Draghi cab is not in the dataset, let's create it.
ita <- pgovs[
  pgovs$country_name_short == "ITA" &
    pgovs$cabinet_name == "Conte II", 
]

ita <- ita[
  ita$party_name_short == "M5S" |
    ita$party_name_short == "PD" |
    ita$party_name_short == "LN" |
    ita$party_name_short == "FI-PdL" |
    ita$party_name_short == "IV" |
    ita$party_name_short == "+EU" |
    ita$party_name_short == "UC" |
    ita$party_name_short == "S" |  
    ita$party_name_short == "CD" |
    ita$party_name_short == "UIE" ,]

itap <- party[
  party$party_name_short == "M5S" |
    party$party_name_short == "PD" &
    party$country_name == "Italy" |
    party$party_name_short == "LN" &
    party$country_name == "Italy" |
    party$party_name_short == "FI-PdL" &
    party$country_name == "Italy" |
    party$party_name_short == "IV" &
    party$country_name == "Italy" |
    party$party_name_short == "+EU" &
    party$country_name == "Italy" |
    party$party_name_short == "UC" &
    party$country_name == "Italy" |
    party$party_name_short == "S" &
    party$country_name == "Italy" |  
    party$party_name_short == "CD" &
    party$country_name == "Italy" |
    party$party_name_short == "UIE" &
    party$country_name == "Italy",]

ita_name <- "Draghi"

ita[6, 14] <- 4
itap[6, 9:11] <- 4

ita_2_lr <- weighted.mean(ita$left_right, ita$seats)
ita_2_la <- weighted.mean(itap$liberty_authority, ita$seats)
ita_2_sm <- weighted.mean(itap$state_market, ita$seats)
ita_share <- sum(ita$seats)/ita$election_seats_total*100
ita_share <- unique(ita_share)

step3[c(224, 226, 228, 230, 232), 6]<- ita_name
step3[c(224, 226, 228, 230, 232), 8] <- ita_2_lr
step3[c(224, 226, 228, 230, 232), 9] <- ita_2_sm
step3[c(224, 226, 228, 230, 232), 10] <- ita_2_la
step3[c(224, 226, 228, 230, 232), 7] <- ita_share


panels <- step3[
  with(step3, order(year, month)),
]

#rio::export(panels, "PanelSet.csv")





