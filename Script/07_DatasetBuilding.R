#COVID waves stringency----
wave1_stringency <- c(mean(string_bel_first$stringency_index), 
                      mean(string_bul_first$stringency_index),
                      mean(string_CYP_first$stringency_index),
                      mean(string_CZE_first$stringency_index),
                      mean(string_de_first$stringency_index),
                      mean(string_DNK_first$stringency_index),
                      mean(string_EST_first$stringency_index),
                      mean(string_esp_first$stringency_index),
                      mean(string_FRA_first$stringency_index),
                      mean(string_uk_first$stringency_index),
                      mean(string_GRC_first$stringency_index),
                      mean(string_HRV_first$stringency_index),
                      mean(string_HUN_first$stringency_index),
                      mean(string_IRL_first$stringency_index),
                      mean(string_ita_first$stringency_index),
                      mean(string_LTU_first$stringency_index),
                      mean(string_LUX_first$stringency_index),
                      mean(string_MLT_first$stringency_index),
                      mean(string_NLD_first$stringency_index),
                      mean(string_POL_first$stringency_index),
                      mean(string_PRT_first$stringency_index),
                      mean(string_ROU_first$stringency_index),
                      mean(string_SVK_first$stringency_index),
                      mean(string_SVN_first$stringency_index),
                      mean(string_sw_first$stringency_index))


wave2_stringency <- c(mean(string_bel_second$stringency_index), 
                      mean(string_bul_second$stringency_index),
                      mean(string_CYP_second$stringency_index),
                      mean(string_CZE_second$stringency_index),
                      mean(string_de_second$stringency_index),
                      mean(string_DNK_second$stringency_index),
                      mean(string_EST_second$stringency_index),
                      mean(string_esp_second$stringency_index),
                      mean(string_FRA_second$stringency_index),
                      mean(string_uk_second$stringency_index),
                      mean(string_GRC_second$stringency_index),
                      mean(string_HRV_second$stringency_index),
                      mean(string_HUN_second$stringency_index),
                      mean(string_IRL_second$stringency_index),
                      mean(string_ita_second$stringency_index),
                      mean(string_LTU_second$stringency_index),
                      mean(string_LUX_second$stringency_index),
                      mean(string_MLT_second$stringency_index),
                      mean(string_NLD_second$stringency_index),
                      mean(string_POL_second$stringency_index),
                      mean(string_PRT_second$stringency_index),
                      mean(string_ROU_second$stringency_index),
                      mean(string_SVK_second$stringency_index),
                      mean(string_SVN_second$stringency_index),
                      mean(string_sw_second$stringency_index))


wave3_stringency <- c(mean(string_bel_third$stringency_index), 
                      mean(string_bul_third$stringency_index),
                      mean(string_CYP_third$stringency_index),
                      mean(string_CZE_third$stringency_index),
                      mean(string_de_third$stringency_index),
                      mean(string_DNK_third$stringency_index),
                      mean(string_EST_third$stringency_index),
                      mean(string_esp_third$stringency_index),
                      mean(string_FRA_third$stringency_index),
                      mean(string_uk_third$stringency_index),
                      mean(string_GRC_third$stringency_index),
                      mean(string_HRV_third$stringency_index),
                      mean(string_HUN_third$stringency_index),
                      mean(string_IRL_third$stringency_index),
                      mean(string_ita_third$stringency_index),
                      mean(string_LTU_third$stringency_index),
                      mean(string_LUX_third$stringency_index),
                      mean(string_MLT_third$stringency_index),
                      mean(string_NLD_third$stringency_index),
                      mean(string_POL_third$stringency_index),
                      mean(string_PRT_third$stringency_index),
                      mean(string_ROU_third$stringency_index),
                      mean(string_SVK_third$stringency_index),
                      mean(string_SVN_third$stringency_index),
                      mean(string_sw_third$stringency_index))


#COVID waves incidence----

incidence_w1 <- c(mean(incidence_BEL_w1$inc_index), 
                      mean(incidence_BGR_w1$inc_index),
                      mean(incidence_CYP_w1$inc_index),
                      mean(incidence_CZE_w1$inc_index),
                      mean(incidence_DEU_w1$inc_index),
                      mean(incidence_DNK_w1$inc_index),
                      mean(incidence_EST_w1$inc_index),
                      mean(incidence_ESP_w1$inc_index),
                      mean(incidence_FRA_w1$inc_index),
                      mean(incidence_GBR_w1$inc_index),
                      mean(incidence_GRC_w1$inc_index),
                      mean(incidence_HRV_w1$inc_index),
                      mean(incidence_HUN_w1$inc_index),
                      mean(incidence_IRL_w1$inc_index),
                      mean(incidence_ITA_w1$inc_index),
                      mean(incidence_LTU_w1$inc_index),
                      mean(incidence_LUX_w1$inc_index),
                      mean(incidence_MLT_w1$inc_index),
                      mean(incidence_NLD_w1$inc_index),
                      mean(incidence_POL_w1$inc_index),
                      mean(incidence_PRT_w1$inc_index),
                      mean(incidence_ROU_w1$inc_index),
                      mean(incidence_SVK_w1$inc_index),
                      mean(incidence_SVN_w1$inc_index),
                      mean(incidence_SWE_w1$inc_index))

incidence_w2 <- c(mean(incidence_BEL_w2$inc_index), 
                  mean(incidence_BGR_w2$inc_index),
                  mean(incidence_CYP_w2$inc_index),
                  mean(incidence_CZE_w2$inc_index),
                  mean(incidence_DEU_w2$inc_index),
                  mean(incidence_DNK_w2$inc_index),
                  mean(incidence_EST_w2$inc_index),
                  mean(incidence_ESP_w2$inc_index),
                  mean(incidence_FRA_w2$inc_index),
                  mean(incidence_GBR_w2$inc_index),
                  mean(incidence_GRC_w2$inc_index),
                  mean(incidence_HRV_w2$inc_index),
                  mean(incidence_HUN_w2$inc_index),
                  mean(incidence_IRL_w2$inc_index),
                  mean(incidence_ITA_w2$inc_index),
                  mean(incidence_LTU_w2$inc_index),
                  mean(incidence_LUX_w2$inc_index),
                  mean(incidence_MLT_w2$inc_index),
                  mean(incidence_NLD_w2$inc_index),
                  mean(incidence_POL_w2$inc_index),
                  mean(incidence_PRT_w2$inc_index),
                  mean(incidence_ROU_w2$inc_index),
                  mean(incidence_SVK_w2$inc_index),
                  mean(incidence_SVN_w2$inc_index),
                  mean(incidence_SWE_w2$inc_index))

incidence_w3 <- c(mean(incidence_BEL_w3$inc_index), 
                  mean(incidence_BGR_w3$inc_index),
                  mean(incidence_CYP_w3$inc_index),
                  mean(incidence_CZE_w3$inc_index),
                  mean(incidence_DEU_w3$inc_index),
                  mean(incidence_DNK_w3$inc_index),
                  mean(incidence_EST_w3$inc_index),
                  mean(incidence_ESP_w3$inc_index),
                  mean(incidence_FRA_w3$inc_index),
                  mean(incidence_GBR_w3$inc_index),
                  mean(incidence_GRC_w3$inc_index),
                  mean(incidence_HRV_w3$inc_index),
                  mean(incidence_HUN_w3$inc_index),
                  mean(incidence_IRL_w3$inc_index),
                  mean(incidence_ITA_w3$inc_index),
                  mean(incidence_LTU_w3$inc_index),
                  mean(incidence_LUX_w3$inc_index),
                  mean(incidence_MLT_w3$inc_index),
                  mean(incidence_NLD_w3$inc_index),
                  mean(incidence_POL_w3$inc_index),
                  mean(incidence_PRT_w3$inc_index),
                  mean(incidence_ROU_w3$inc_index),
                  mean(incidence_SVK_w3$inc_index),
                  mean(incidence_SVN_w3$inc_index),
                  mean(incidence_SWE_w3$inc_index))



#Combine dateset----
#ParlGov
data <- govs_cl %>%
  group_by(country_name_short, country_name, cabinet_name) %>%
  slice(1) %>%
  ungroup()

#Incidence COVID

data_s <- subset(data, select = -c(seats, left_right, state_market, liberty_authority, election_seats_total))
data_s <- cbind(data_s, incidence_w1)
data_s <- cbind(data_s, incidence_w2)
data_s <- cbind(data_s, incidence_w3)

#Stringency index

data_s <- cbind(data_s, wave1_stringency)
data_s <- cbind(data_s, wave2_stringency)
data_s <- cbind(data_s, wave3_stringency)

#Intensive care units

data_s2 <- merge(data_s, icu4,id = country_name)

#Debt
data_fin <- merge(data_s2, debt, id = country_name) 

data_main <- subset(data_fin, select = -c(country_name))
data_main$ICU<-data_main$ICU/10

#rio::export(data_main, "DATA_PG.csv")








