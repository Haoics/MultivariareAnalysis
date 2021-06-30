##ICU * 1000 INHABITANTS
icu <- rio::import(here::here("Dataset/", "intensive_care.csv"))
icu2<-select(icu, LOCATION, TIME, Value)

icu3 <- icu2[
  icu2$LOCATION == "ITA" |
  icu2$LOCATION == "SWE" |
  icu2$LOCATION == "DEU" |
  icu2$LOCATION== "ESP",
]

icu4<-icu3[
  icu3$TIME >= 2017,
]

icu4<-arrange(icu4, by = TIME)
icu4[2:4,] <- NA
icu5<-drop_na(icu4)

##MANUALLY INSERT. SOURCE: BBC
eng<-c("GBR", 2017, 2.54)
icu6 <- rbind(icu5, eng)

