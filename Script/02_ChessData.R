chess <- rio::import(here::here("Dataset/", "CHES2019V3.dta"))

#filtering dataset----
chess2 <- chess[
    chess$party == "CDU" |
    chess$party == "CSU" |
    chess$party == "SPD" |
    chess$party == "ECP" |
    chess$party == "EM|GCE" |
    chess$party == "Podemos" |
    chess$party == "PSOE" |
    chess$party == "UP" |
    chess$party == "CONS" |
    chess$party == "IV" |
    chess$party == "M5S" |
    chess$party == "PC" |
    chess$party == "PD" |
    chess$party == "SI" |
    chess$party == "MP" |
    chess$party == "S/SAP",
]

chess3 <- chess2[
             chess2$country == "3" |
             chess2$country == "5" |
             chess2$country == "8" |
             chess2$country == "11" |
             chess2$country == "16" ,
]

#managment dataset----

chess4 <- select(chess3, country, party, lrgen, lrecon, galtan)

cdu <- chess4[1, ]
csu <- chess4[3, ]
cdu[, 2] <- NA
csu[,2] <- NA
cdu_csu <- (cdu+csu)/2
cdu_csu[,2] <- "CDU+CSU"

chess_5 <- rbind(chess4, cdu_csu)

chess_5[1,] <- NA
chess_5[3,] <- NA

chess6 <- drop_na(chess_5)

##medie ponderate----
lr_ch_ita<-(3.21*112 + 4.78*227 + 1.44*14)/353
lr_ch_de<-(3.62*153 + 246*6.52)/(246+153)
lr_ch_esp<-(1.93*35 + 120*3.6)/155
lr_ch_gb<-7.12            
lr_ch_sw<-(3.29*16 + 100*3.88)/116


sm_ch_ita<-(3.58*112 + 227*3.21 + 14*1)/353
sm_ch_de<-(153*3.71 + 246*6.14)/(246+153)
sm_ch_esp<-(35*2.13 + 120*3.8)/155
sm_ch_gb<-7.06
sm_ch_sw<-(4.12*100 + 16*3.94)/116


la_ch_ita<-(2.26*112 + 227*3.74 + 14*0.69)/353
la_ch_de<-(153*3.38 + 246*6.57)/(246+153)
la_ch_esp<-(35*1.33 + 120*2.93)/155
la_ch_gb<-6.17
la_ch_sw<-(4.41*100 + 16*1.59)/116




