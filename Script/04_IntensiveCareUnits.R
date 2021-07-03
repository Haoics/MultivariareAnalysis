##ICU * 1000 INHABITANTS
icu <- rio::import(here::here("Dataset/", "intensive_care.csv"))
icu2<-select(icu, LOCATION, TIME, Value)

icu3 <- icu2[
  icu2$LOCATION == "ITA" |
    icu2$LOCATION == "DEU" |
    icu2$LOCATION == "ESP" |
    icu2$LOCATION == "GBR" |
    icu2$LOCATION == "SWE" |
    icu2$LOCATION == "BEL" |
    icu2$LOCATION == "BGR" |
    icu2$LOCATION == "CYP" |
    icu2$LOCATION == "CZE" |
    icu2$LOCATION == "DNK" |
    icu2$LOCATION == "EST" |
    icu2$LOCATION == "FRA" |
    icu2$LOCATION == "GRC" |
    icu2$LOCATION == "HRV" |
    icu2$LOCATION == "HUN" |
    icu2$LOCATION == "IRL" |
    icu2$LOCATION == "LTU" |
    icu2$LOCATION == "LUX" |
    icu2$LOCATION == "MLT" |
    icu2$LOCATION == "NLD" |
    icu2$LOCATION == "POL" |
    icu2$LOCATION == "PRT" |
    icu2$LOCATION == "ROU" |
    icu2$LOCATION == "SVK" |
    icu2$LOCATION == "SVN" , ]





icu4<-icu3[
  icu3$TIME >= 2017,
]

icu4<-arrange(icu4, by = TIME)
icu4<-filter(icu4, TIME == 2017)
icu4[2:4,] <- NA
icu5<-drop_na(icu4)

##MANUALLY INSERT. SOURCE: BBC
eng<-c("GBR", 2017, 2.54)
bgr<-c("BGR", 2017, 6.00)
cyp<-c("CYP", 2017,  )
rou<-c("ROU", 2017,)
hrv<-c("HRV", )

icu6 <- rbind(icu5, eng)

