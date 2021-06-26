library(tidyverse)
pgovs <- rio::import(here::here("Dataset/", "cabinet.xlsx"))
party <- rio::import(here::here("Dataset/","party.xlsx"))
#pandemic cabinets----
parl_fil <- pgovs[
      pgovs$cabinet_name == "Conte II" |
      pgovs$cabinet_name == "Merkel V" |
      pgovs$cabinet_name == "Lofven III" |
      pgovs$cabinet_name == "Sanchez III" |
      pgovs$cabinet_name == "Johnson II",
]

control_party <- parl_fil[parl_fil$cabinet_party ==1,]

party_short <- party[
    party$party_name_short == "CDU+CSU" |
    party$party_name_short == "SPD" |
    party$party_name_short == "ECP" |
    party$party_name_short == "EM|GCE" |
    party$party_name_short == "P" |
    party$party_name_short == "PSOE" |
    party$party_name_short == "UP" |
    party$party_name_short == "Con" |
    party$party_name_short == "IV" |
    party$party_name_short == "M5S" |
    party$party_name_short == "PC" |
    party$party_name_short == "PD" |
    party$party_name_short == "S" |
    party$party_name_short == "MP" |
    party$party_name_short == "SAP" ,
]

party_short2 <- select(party_short, party_name, left_right, state_market, liberty_authority )

parl_fil$left_right <- ifelse(parl_fil$party_name_short == "M5S",  NA, parl_fil$left_right)

cabs <- merge(parl_fil, party_short2, id = party_name)
#italia viva: decidere che cazzo fare con renzi: lo impicchiamo o gli scopiamo la moglie?

#calculating seats shares----
govs <- cabs %>%  
  group_by(country_name) %>% 
  mutate(share_seats = (sum(seats)/election_seats_total*100))

#left-right scale weighted mean PARLGOV OPERAZIONALIZATION----
#M5S has value NA in all the three scales: we have decided to give them an arbitrary value = 4.

lr_wm_ita <- (2.62*112 + 4*227 + 1.3*14)/353 # 3.45 
lr_wm_de <- (6.25*246 + 3.65)



#ordering govs---
govs_ordered <- select(govs, cabinet_name, country_name, share_seats, left_right, state_market, liberty_authority)
