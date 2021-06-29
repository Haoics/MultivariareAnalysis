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

party_short2 <- select(party_short, party_name, party_name_short, left_right, state_market, liberty_authority)

parl_fil$left_right <- ifelse(parl_fil$party_name_short == "M5S",  NA, parl_fil$left_right)

cabs <- merge(parl_fil, party_short2, id = party_name)
#italia viva: decidere che cazzo fare con renzi: lo impicchiamo o gli scopiamo la moglie?

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

lr <- c(lr_wm_ita, lr_wm_de, lr_wm_esp, lr_wm_gb, lr_wm_sw)

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


#ordering govs---
govs_ordered <- select(govs, cabinet_name, country_name, share_seats, left_right, state_market, liberty_authority)

parlgov_final <-  rep(list(vector(mode ="list", length = 5)), 3)

#left right scale insert values
parlgov_final[[1]][1]<- lr_wm_ita
parlgov_final[[1]][2]<- lr_wm_de
parlgov_final[[1]][3]<- lr_wm_esp
parlgov_final[[1]][4]<- lr_wm_gb
parlgov_final[[1]][5]<- lr_wm_sw

#state makert insert values
parlgov_final[[2]][1]<- sm_wm_ita
parlgov_final[[2]][2]<- sm_wm_de
parlgov_final[[2]][3]<- sm_wm_esp
parlgov_final[[2]][4]<- sm_wm_gb
parlgov_final[[2]][5]<- sm_wm_sw

#liberatism authoritarianis insert data
parlgov_final[[3]][1]<- la_wm_ita
parlgov_final[[3]][2]<- la_wm_de
parlgov_final[[3]][3]<- la_wm_esp
parlgov_final[[3]][4]<- la_wm_gb
parlgov_final[[3]][5]<- la_wm_sw

parlgov_final <- data.frame(unlist(parlgov_final))

#df$ls_scale <- parlgov_final[[1]][1:5]
















