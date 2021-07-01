library(tidyverse)
library(lubridate)

covid <- rio::import(here::here("Dataset/", "covid.csv"))

covid_cnt <- covid[
  covid$location == "Italy" |
    covid$location == "Germany" |
    covid$location == "Spain" |
    covid$location == "United Kingdom" |
    covid$location == "Sweden", 
]

#pca----
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
                                                life_expectancy, human_development_index))

str(covid_fit_num)
pca <- princomp(~ ., data = covid_fit_num, cor = T)
summary(pca)

factoextra::get_eigenvalue(pca)

fact <- factanal(covid_fit_num, 8, rotation = "varimax", lower = 0.1)
print(fact, digits = 4, cutoff = .3, sort = TRUE)



incidence1 <- select(covid_fit2, location, date, new_deaths_per_million, icu_patients_per_million)
incidencev <- (incidence1$new_deaths_per_million + incidence1$icu_patients_per_million)/2
incidence <- select(incidence1, location, date)
incidence$inc_index <- incidencev
View(incidence)
#Incidence Italy
incidencew1_ita <- incidence[
      incidence$date > as_date("2020-03-03")  &
      incidence$date < as_date("2020-06-15") &
      incidence$location == "Italy",
  ]

incidencew2_ita <- incidence[
  incidence$date > as_date("2020-09-15")  &
    incidence$date < as_date("2021-02-19") &
    incidence$location == "Italy",
]

incidencew3_ita <- incidence[
  incidence$date > as_date("2021-02-19")  &
    incidence$date < as_date("2021-06-28") &
    incidence$location == "Italy",
]


#Incidence Germany----
incidencew1_deu <- incidence[
  incidence$date > as_date("2020-03-11")  &
    incidence$date < as_date("2020-06-30") &
    incidence$location == "Germany",
]

incidencew2_deu <- incidence[
  incidence$date > as_date("2020-09-15")  &
    incidence$date < as_date("2021-02-16") &
    incidence$location == "Germany",
]

incidencew3_deu <- incidence[
  incidence$date > as_date("2021-02-15")  &
    incidence$date < as_date("2021-06-28") &
    incidence$location == "Germany",
]

#Incidence Spain----
incidencew1_esp <- incidence[
  incidence$date > as_date("2020-03-10")  &
    incidence$date < as_date("2020-06-10") &
    incidence$location == "Spain",
]

incidencew2_esp <- incidence[
  incidence$date > as_date("2020-06-10")  &
    incidence$date < as_date("2020-12-10") &
    incidence$location == "Spain",
]

incidencew3_esp <- incidence[
  incidence$date > as_date("2020-12-11")  &
    incidence$date < as_date("2021-06-28") &
    incidence$location == "Spain",
]

#Incidence UK----

incidencew1_uk <- incidence[
  incidence$date > as_date("2020-03-11")  &
    incidence$date < as_date("2020-07-02") &
    incidence$location == "United Kingdom",
]

incidencew2_uk <- incidence[
  incidence$date > as_date("2020-09-03")  &
    incidence$date < as_date("2020-12-01") &
    incidence$location == "United Kingdom",
]

incidencew3_uk <- incidence[
  incidence$date > as_date("2020-12-02")  &
    incidence$date < as_date("2021-05-15") &
    incidence$location == "United Kingdom",
]

#Incidence Sweden----
incidencew1_sw <- incidence[
  incidence$date > as_date("2020-03-08")  &
    incidence$date < as_date("2020-08-27") &
    incidence$location == "Sweden",
]

incidencew2_sw <- incidence[
  incidence$date > as_date("2020-08-27")  &
    incidence$date < as_date("2021-01-29") &
    incidence$location == "Sweden",
]

incidencew3_sw <- incidence[
  incidence$date > as_date("2021-01-29")  &
    incidence$date < as_date("2021-06-28") &
    incidence$location == "Sweden",
]


















