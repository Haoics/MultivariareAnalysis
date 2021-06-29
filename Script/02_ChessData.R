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






