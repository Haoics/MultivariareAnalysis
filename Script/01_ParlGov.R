library(tidyverse)
pgovs <- rio::import(here::here("Dataset/", "cabinet.xlsx"))
party <- rio::import(here::here("Dataset/","party.xlsx"))
#pandemic cabinets----
parl_fil <- pgovs[
      pgovs$cabinet_name == "Conte II" |
      pgovs$cabinet_name == "Merkel V" |
      pgovs$cabinet_name == "Lofven III" |
      pgovs$cabinet_name == "Sanchez III" |
      pgovs$cabinet_name == "Johnson II" |
      pgovs$cabinet_name == "Marin"  |
      pgovs$cabinet_name ==  "Morawiecki II" |
        pgovs$cabinet_name ==  "Wilmes II" | 
        pgovs$cabinet_name ==  "Costa II" |
        pgovs$cabinet_name ==  "Bierlein II" |
        pgovs$cabinet_name ==  "Skvernelis III" |
        pgovs$cabinet_name ==  "Mitsotakis Kyr" |
        pgovs$cabinet_name ==  "Frederiksen" |
        pgovs$cabinet_name ==  "Ratas II" |
        pgovs$cabinet_name ==  "Karins" |
        pgovs$cabinet_name ==  "Bettel II" |
        pgovs$cabinet_name ==  "Jansa III" |
        pgovs$cabinet_name ==  "Matovic" |
        pgovs$cabinet_name ==  "Abela" |
        pgovs$cabinet_name ==  "Babis II" |
        pgovs$cabinet_name ==  "Orban IV" |
        pgovs$cabinet_name ==  "Anastasiades IV" |
        pgovs$cabinet_name ==  "Rutte V" |
        pgovs$cabinet_name ==  "Plenkovic II" |
        pgovs$cabinet_name ==  "Borisov III" |
        pgovs$cabinet_name ==  "Philippe II" |
        pgovs$cabinet_name ==  "Varadkar II" |
        pgovs$cabinet_name ==  "Orban II" , ]
        


        
control_party <- parl_fil[parl_fil$cabinet_party ==1,]

unique(control_party$cabinet_party)
str(control_party)
str(party)
#party_short <- party[
   # party$party_name_short == "CDU+CSU" |
    ##party$party_name_short == "SPD" |
    ##party$party_name_short == "ECP" |
    #party$party_name_short == "EM|GCE" |
    #party$party_name_short == "P" |
    #party$party_name_short == "PSOE" |
    #party$party_name_short == "UP" |
    #party$party_name_short == "Con" |
    #party$party_name_short == "IV" |
    #party$party_name_short == "M5S" |
    #party$party_name_short == "PC" |
    #party$party_name_short == "PD" |
    #party$party_name_short == "S" |
    #party$party_name_short == "MP" |
    #party$party_name_short == "SAP" ,
#]
#Problem resolution----
#M5S
control_party$party_id <- ifelse(control_party$party_name_short == "M5S",  2155, control_party$party_id)
control_party$country_id <- ifelse(control_party$party_name_short == "M5S",  26, control_party$country_id)
control_party$left_right <- ifelse(control_party$party_name_short == "M5S",  4, control_party$left_right)
party$left_right <- ifelse(party$party_name_short == "M5S",  4, party$left_right)

control_party_clean <- drop_na(control_party)

merged <- merge(party, control_party_clean, id = party_name)

a <- unique(merged$party_id)
a <- sort(a)
b <- unique(control_party_clean$party_id)
b <- sort(b)

#partiti da mettere a posto = LA e DL|VAS

#variables selection----
party_short <- select(merged, party_name_english, party_name_short, left_right, state_market, liberty_authority)

#calculating seats shares----
govs <- cabs %>%  
  group_by(country_name) %>% 
  mutate(share_seats = (sum(seats)/election_seats_total*100))

#left-right scale weighted mean PARLGOV OPERAZIONALIZATION----
#M5S has value NA in all the three scales: we have decided to give them an arbitrary value = 4.
#per ora calcolo a mano, poi verrà fatto meglio

lr_wm_ita <- (2.62*112 + 4*227 + 1.3*14)/353 # 3.45 
lr_wm_de <- (6.25*246 + 3.65*153)/(246+153) #5.25 
lr_wm_esp <- (1.3*7 + 1.3*2 + 3.73*120 + 1.3*26 + 1.3*0)/(7+2+120+26+0) #3.18
lr_wm_gb <- 7.42
lr_wm_sw <- (3.37*16 + 3.44*100)/116 #3.43


sm_wm_ita <- (112*2.98 +227*4 + 14*1.4)/353 #3.57
sm_wm_de <- (6.34*246 + 3.84*153)/(246+153) #5.38
sm_wm_esp <- (1.4*7 + 1.4*2 + 4.00*120 + 1.4*26 + 1.4*0)/(7+2+120+26+0) #3.41
sm_wm_gb <- 7.57
sm_wm_sw <- (3.38*16 + 3.56*100)/116 #3.53


la_wm_ita <- (2.09*112 + 4*227 + 3*14)/353 # 3.35
la_wm_de <- (6.93*246 + 3.97*153)/(246+153) # 5.79
la_wm_esp <- (3*7 + 3*2 + 3.03*120 + 3*26 + 3*0)/(7+2+120+26+0) #3.023
la_wm_gb <- 7.19
la_wm_sw <- (2.51*16 + 4.44*100)/116 #4.17













