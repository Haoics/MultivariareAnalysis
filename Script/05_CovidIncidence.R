library(tidyverse)
library(lubridate)

#Lines 4-14 commented because of the larg size of covid dataset. We have exported
# the filtered dataset and worked with it.

#covid <- rio::import(here::here("Dataset/", "covid.csv"))

#covid_cnt <- covid[
#  covid$iso_code == "ITA" |
#    covid$iso_code == "DEU" |
#    covid$iso_code == "ESP" |
#    covid$iso_code == "GBR" |
#    covid$iso_code == "SWE" |
#    covid$iso_code == "BEL" |
#    covid$iso_code == "BGR" |
#    covid$iso_code == "CYP" |
#    covid$iso_code == "CZE" |
#    covid$iso_code == "DNK" |
#    covid$iso_code == "EST" |
#    covid$iso_code == "FRA" |
#    covid$iso_code == "GRC" |
#    covid$iso_code == "HRV" |
#    covid$iso_code == "HUN" |
#    covid$iso_code == "IRL" |
#    covid$iso_code == "LTU" |
#    covid$iso_code == "LUX" |
#    covid$iso_code == "MLT" |
#    covid$iso_code == "NLD" |
#    covid$iso_code == "POL" |
#    covid$iso_code == "PRT" |
#    covid$iso_code == "ROU" |
#    covid$iso_code == "SVK" |
#    covid$iso_code == "SVN" , ]

#rio::export(covid_cnt, "covid_filtered.csv")


covid_cnt <- rio::import(here::here("Dataset/", "covid_filtered.csv"))
View(covid_cnt)

#install.packages("imputeTS")
library(imputeTS)
covid_fit <- na_replace(covid_cnt, 0)

covid_fit2 <- covid_fit[
  covid_fit$date > as_date("2020-03-01"),
]

covid_fit_num <- subset(covid_fit2, select = -c(tests_units, population, population_density, stringency_index,
                                                median_age, aged_65_older, aged_70_older, gdp_per_capita,
                                                extreme_poverty, cardiovasc_death_rate, diabetes_prevalence,
                                                female_smokers, male_smokers, handwashing_facilities, hospital_beds_per_thousand,
                                                life_expectancy, human_development_index, iso_code, continent, location, date))

str(covid_fit_num)
#pca----
pca <- princomp(~ ., data = covid_fit_num, cor = T)
summary(pca)

factoextra::get_eigenvalue(pca)

fact <- factanal(covid_fit_num, 8, rotation = "varimax", lower = 0.1)
print(fact, digits = 4, cutoff = .3, sort = TRUE)



incidence1 <- select(covid_fit2, iso_code, date, new_deaths_per_million, icu_patients_per_million)
incidencev <- (incidence1$new_deaths_per_million + incidence1$icu_patients_per_million)/20
incidence <- select(incidence1, iso_code, date)
incidence$inc_index <- incidencev
View(incidence)

#Italy incidence----
incidence_ITA_w1 <- incidence[
  incidence$date > as_date("2020-03-03")  &
    incidence$date < as_date("2020-06-15") &
    incidence$iso_code == "ITA",
]

incidence_ITA_w2 <- incidence[
  incidence$date > as_date("2020-09-15")  &
    incidence$date < as_date("2021-02-19") &
    incidence$iso_code == "ITA",
]

incidence_ITA_w3 <- incidence[
  incidence$date > as_date("2021-02-19")  &
    incidence$date < as_date("2021-06-28") &
    incidence$iso_code == "ITA",
]

#Germany incidece----
incidence_DEU_w1 <- incidence[
  incidence$date > as_date("2020-03-11")  &
    incidence$date < as_date("2020-06-30") &
    incidence$iso_code == "DEU",
]

incidence_DEU_w2 <- incidence[
  incidence$date > as_date("2020-09-15")  &
    incidence$date < as_date("2021-02-16") &
    incidence$iso_code == "DEU",
]

incidence_DEU_w3 <- incidence[
  incidence$date > as_date("2021-02-15")  &
    incidence$date < as_date("2021-06-28") &
    incidence$iso_code == "DEU",
]

#Spain incidence----
incidence_ESP_w1 <- incidence[
  incidence$date > as_date("2020-03-10")  &
    incidence$date < as_date("2020-06-10") &
    incidence$iso_code == "ESP",
]

incidence_ESP_w2 <- incidence[
  incidence$date > as_date("2020-06-10")  &
    incidence$date < as_date("2020-12-10") &
    incidence$iso_code == "ESP",
]

incidence_ESP_w3 <- incidence[
  incidence$date > as_date("2020-12-11")  &
    incidence$date < as_date("2021-06-28") &
    incidence$iso_code== "ESP",
]

#UK incidence----
incidence_GBR_w1 <- incidence[
  incidence$date > as_date("2020-03-11")  &
    incidence$date < as_date("2020-07-02") &
    incidence$iso_code == "GBR",
]

incidence_GBR_w2 <- incidence[
  incidence$date > as_date("2020-09-03")  &
    incidence$date< as_date("2020-12-1") &
    incidence$iso_code == "GBR",
]

incidence_GBR_w3 <- incidence[
  incidence$date > as_date("2020-12-02")  &
    incidence$date < as_date("2021-05-15") &
    incidence$iso_code == "GBR",
]
#attention to england wawes. say it in report.

#Sweden incidence----
incidence_SWE_w1 <- incidence[
  incidence$date > as_date("2020-03-08")  &
    incidence$date < as_date("2020-08-27") &
    incidence$iso_code == "SWE",
]

incidence_SWE_w2 <- incidence[
  incidence$date > as_date("2020-08-27")  &
    incidence$date < as_date("2021-01-29") &
    incidence$iso_code == "SWE",
]

incidence_SWE_w3 <- incidence[
  incidence$date > as_date("2021-01-29")  &
    incidence$date < as_date("2021-06-28") &
    incidence$iso_code == "SWE",
]

#Belgium incidence----
incidence_BEL_w1 <- incidence[
  incidence$date > as_date("2020-03-10")  &
    incidence$date < as_date("2020-06-15") &
    incidence$iso_code == "BEL",
]


incidence_BEL_w2 <- incidence[
  incidence$date > as_date("2020-08-01")  &
    incidence$date < as_date("2021-01-02") &
    incidence$iso_code == "BEL",
]

incidence_BEL_w3 <- incidence[
  incidence$date > as_date("2021-01-03")  &
    incidence$date < as_date("2021-06-28") &
    incidence$iso_code == "BEL",
]

#Bulgaria incidence----
incidence_BGR_w1 <- incidence[
  incidence$date > as_date("2020-03-25")  &
    incidence$date < as_date("2020-09-01") &
    incidence$iso_code == "BGR",
]

incidence_BGR_w2 <- incidence[
  incidence$date > as_date("2020-09-01")  &
    incidence$date < as_date("2021-01-20") &
    incidence$iso_code == "BGR",
]

incidence_BGR_w3 <- incidence[
  incidence$date > as_date("2021-01-21")  &
    incidence$date < as_date("2021-06-28") &
    incidence$iso_code == "BGR",
]

#Croazia incidence----
incidence_HRV_w1 <- incidence[
  incidence$date > as_date("2020-03-25")  &
    incidence$date < as_date("2020-08-07") &
    incidence$iso_code == "HRV",
]

incidence_HRV_w2 <- incidence[
  incidence$date > as_date("2020-08-07")  &
    incidence$date < as_date("2021-02-15") &
    incidence$iso_code == "HRV",
]

incidence_HRV_w3 <- incidence[
  incidence$date > as_date("2021-02-15")  &
    incidence$date < as_date("2021-06-28") &
    incidence$iso_code == "HRV",
]

#DNK incidence----
incidence_DNK_w1 <- incidence[
  incidence$date > as_date("2020-03-10")  &
    incidence$date < as_date("2020-07-22") &
    incidence$iso_code== "DNK",
]

incidence_DNK_w2 <- incidence [
  incidence$date > as_date("2020-07-22")  &
    incidence$date < as_date("2021-02-17") &
    incidence$iso_code == "DNK",
]

incidence_DNK_w3<- incidence [
  incidence $date > as_date("2021-02-17")  &
    incidence $date < as_date("2021-06-28") &
    incidence $iso_code == "DNK",
]

#Cypro incidence----
incidence_CYP_w1 <- incidence [
  incidence$date > as_date("2020-03-14")  &
    incidence$date < as_date("2020-09-02") &
    incidence$iso_code == "CYP",
]

incidence_CYP_w2 <-   incidence [
  incidence$date > as_date("2020-09-02")  &
    incidence$date < as_date("2021-02-14") &
    incidence$iso_code == "CYP",
]

incidence_CYP_w3 <-   incidence [
  incidence $date > as_date("2021-02-14")  &
    incidence$date < as_date("2021-06-17") &
    incidence$iso_code == "CYP",
]

#CZE incidence----
#THIRD WAWE HAS TWO PICKS
incidence_CZE_w1 <-   incidence [
  incidence$date > as_date("2020-03-14")  &
    incidence$date < as_date("2020-07-15") &
    incidence$iso_code == "CZE",
]

incidence_CZE_w2 <- incidence [
  incidence$date > as_date("2020-07-15")  &
    incidence$date < as_date("2020-12-08") &
    incidence$iso_code == "CZE",
]

mean(incidence_CZE_w2$inc_index)

incidence_CZE_w3 <-   incidence [
  incidence$date > as_date("2020-12-08")  &
    incidence$date < as_date("2021-06-28") &
    incidence$iso_code == "CZE",
]

#EST incidence----
incidence_EST_w1 <- incidence [
  incidence$date > as_date("2020-03-14")  &
    incidence$date < as_date("2020-06-30") &
    incidence$iso_code == "EST",
]

incidence_EST_w2 <- incidence [
  incidence$date > as_date("2020-08-25")  &
    incidence$date < as_date("2021-02-04") &
    incidence$iso_code == "EST",
]

incidence_EST_w3 <- incidence[
  incidence$date > as_date("2021-02-05")  &
    incidence$date < as_date("2021-06-28") &
    incidence$iso_code == "EST",
]

#FRA incidence----
incidence_FRA_w1 <- incidence[
  incidence$date > as_date("2020-03-10")  &
    incidence$date < as_date("2020-06-30") &
    incidence$iso_code == "FRA",
]

incidence_FRA_w2<- incidence[
  incidence$date > as_date("2020-08-10")  &
    incidence$date< as_date("2020-12-07") &
    incidence$iso_code== "FRA",
]

incidence_FRA_w3<- incidence[
  incidence$date > as_date("2020-12-07")  &
    incidence$date < as_date("2021-06-28") &
    incidence$iso_code == "FRA",
]

#GRC incidence----
incidence_GRC_w1 <- incidence[
  incidence$date > as_date("2020-03-16")  &
    incidence$date< as_date("2020-07-30") &
    incidence $iso_code == "GRC",
]

incidence_GRC_w2 <- incidence[
  incidence$date > as_date("2020-08-01")  &
    incidence$date < as_date("2021-01-22") &
    incidence$iso_code == "GRC",
]

incidence_GRC_w3 <- incidence[
  incidence$date> as_date("2021-01-23")  &
    incidence$date < as_date("2021-06-25") &
    incidence$iso_code == "GRC",
]

#HUN incidence----
incidence_HUN_w1 <- incidence[
  incidence$date > as_date("2020-03-27")  &
    incidence$date < as_date("2020-08-20") &
    incidence$iso_code == "HUN",
]

incidence_HUN_w2 <- incidence[
  incidence$date > as_date("2020-08-21")  &
    incidence$date< as_date("2021-01-26") &
    incidence$iso_code == "HUN",
]

incidence_HUN_w3 <- incidence[
  incidence$date > as_date("2021-01-27")  &
    incidence$date< as_date("2021-06-28") &
    incidence$iso_code == "HUN",
]

#IRL incidence----
incidence_IRL_w1 <- incidence[
  incidence$date > as_date("2020-03-14")  &
    incidence$date < as_date("2020-06-15") &
    incidence$iso_code == "IRL",
]

incidence_IRL_w2 <- incidence [
  incidence$date > as_date("2020-08-05")  &
    incidence$date < as_date("2021-12-08") &
    incidence$iso_code == "IRL",
]

incidence_IRL_w3 <- incidence[
  incidence$date > as_date("2020-12-09")  &
    incidence$date< as_date("2021-06-28") &
    incidence$iso_code == "IRL",
]
#LTU incidence----
incidence_LTU_w1 <- incidence[
  incidence$date > as_date("2020-03-21")  &
    incidence$date < as_date("2020-06-15") &
    incidence$iso_code == "LTU",
]

incidence_LTU_w2 <- incidence[
  incidence$date > as_date("2020-08-15")  &
    incidence$date < as_date("2021-02-18") &
    incidence$iso_code == "LTU",
]

incidence_LTU_w3 <- incidence[
  incidence$date > as_date("2021-02-19")  &
    incidence$date < as_date("2021-06-28") &
    incidence$iso_code == "LTU",
]
#LUX incidence----
incidence_LUX_w1 <- incidence[
  incidence$date > as_date("2020-03-12") &
    incidence$date < as_date("2020-06-10") &
    incidence$iso_code == "LUX",
]

incidence_LUX_w2 <- incidence[
  incidence$date > as_date("2020-06-15") &
    incidence$date < as_date("2021-01-20") &
    incidence$iso_code == "LUX",
]

incidence_LUX_w3 <- incidence[
  incidence$date > as_date("2021-01-21") &
    incidence$date < as_date("2021-06-22") &
    incidence$iso_code == "LUX",
]

#MLT incidence----
incidence_MLT_w1 <- incidence[
  incidence$date > as_date("2020-03-14") &
    incidence$date < as_date("2020-06-20") &
    incidence$iso_code == "MLT",
]

incidence_MLT_w2 <- incidence[
  incidence$date > as_date("2020-07-25") &
    incidence$date < as_date("2020-12-19") &
    incidence$iso_code == "MLT",
]

incidence_MLT_w3 <- incidence[
  incidence$date > as_date("2020-12-20") &
    incidence$date < as_date("2021-06-28") &
    incidence$iso_code == "MLT",
]

#NLD incidence----
incidence_NLD_w1 <- incidence[
  incidence$date > as_date("2020-03-11") &
    incidence$date < as_date("2020-06-25") &
    incidence$iso_code == "NLD",
]

incidence_NLD_w2 <- incidence[
  incidence$date > as_date("2020-07-20") &
    incidence$date < as_date("2021-02-14") &
    incidence$iso_code == "NLD",
]

incidence_NLD_w3 <- incidence[
  incidence$date > as_date("2021-02-15") &
    incidence$date < as_date("2021-06-28") &
    incidence$iso_code == "NLD",
]

#POL incidence----
incidence_POL_w1 <- incidence[
  incidence$date > as_date("2020-03-25") &
    incidence$date < as_date("2020-07-10") &
    incidence$iso_code == "POL",
]

incidence_POL_w2 <- incidence[
  incidence$date > as_date("2020-07-15") &
    incidence$date < as_date("2021-02-02") &
    incidence$iso_code == "POL",
]

incidence_POL_w3 <- incidence[
  incidence$date > as_date("2021-02-03") &
    incidence$date < as_date("2021-06-28") &
    incidence$iso_code == "POL",
]

#PRT incidence----
incidence_PRT_w1 <- incidence[
  incidence$date > as_date("2020-03-15") &
    incidence$date < as_date("2020-08-11") &
    incidence$iso_code == "PRT",
]

incidence_PRT_w2 <- incidence[
  incidence$date > as_date("2020-08-15") &
    incidence$date < as_date("2020-12-28") &
    incidence$iso_code == "PRT",
]

incidence_PRT_w3 <- incidence[
  incidence$date > as_date("2020-12-30") &
    incidence$date < as_date("2021-05-10") &
    incidence$iso_code == "PRT",
]

#ROU incidence----
incidence_ROU_w1 <- incidence[
  incidence$date > as_date("2020-03-23") &
    incidence$date < as_date("2020-06-04") &
    incidence$iso_code == "ROU",
]

incidence_ROU_w2 <- incidence[
  incidence$date > as_date("2020-06-15") &
    incidence$date < as_date("2021-02-07") &
    incidence$iso_code == "ROU",
]

incidence_ROU_w3 <- incidence[
  incidence$date > as_date("2021-02-18") &
    incidence$date < as_date("2021-06-28") &
    incidence$iso_code == "ROU",
]

#SVK incidence----
incidence_SVK_w1 <- incidence[
  incidence$date > as_date("2020-03-21") &
    incidence$date < as_date("2020-06-10") &
    incidence$iso_code == "SVK",
]

incidence_SVK_w2 <- incidence[
  incidence$date > as_date("2020-08-07") &
    incidence$date < as_date("2020-11-24") &
    incidence$iso_code == "SVK",
]

incidence_SVK_w3 <- incidence[
  incidence$date > as_date("2020-11-25") &
    incidence$date < as_date("2021-06-28") &
    incidence$iso_code == "SVK",
]

#SVN incidence----
incidence_SVN_w1 <- incidence[
  incidence$date > as_date("2020-03-11") &
    incidence$date < as_date("2020-06-20") &
    incidence$iso_code == "SVN",
]

incidence_SVN_w2 <- incidence[
  incidence$date > as_date("2020-08-07") &
    incidence$date < as_date("2021-03-13") &
    incidence$iso_code == "SVN",
]

incidence_SVN_w3 <- incidence[
  incidence$date > as_date("2021-03-14") &
    incidence$date < as_date("2021-06-28") &
    incidence$iso_code == "SVN",
]

##cleaning env
rm(covid_cnt, covid_fit, covid_fit2, covid_fit_num, pca, fact, incidence1, incidencev, incidence)




