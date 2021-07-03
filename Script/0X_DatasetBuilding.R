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

#Intensive care units----

data_icu <- merge(data, icu4, id = country_name)
data_waves <- cbind(data_icu, wave1_stringency)
data_waves2 <- cbind(data_waves, wave2_stringency)
data_waves <- cbind(data_waves2, wave3_stringency)
data_waves[14,16] <- 53.08496  #nel vettore non computava la media, l'abbiamo inserita a mano

#Dataset Building DA RIVEDERE----
#Base df with operationalisations:
country <- unique(govs$country_name_short)
cabinet <- unique(govs$cabinet_name)
share <- unique(govs$share_seats)

main <- data.frame(country, cabinet, share, lr_pg, la_pg, sm_pg, lr_ch, la_ch, sm_ch, wave1_stringency,
                   wave2_stringency, wave3_stringency, intensive_care_units, wave1_inc, wave2_inc, wave3_inc)
first_wave <- data.frame(country, cabinet, lr_pg, la_pg, sm_pg, lr_ch, la_ch, sm_ch, wave1_stringency, intensive_care_units, wave1_inc)
second_wave <- data.frame(country, cabinet, lr_pg, la_pg, sm_pg, lr_ch, la_ch, sm_ch, wave2_stringency, intensive_care_units, wave2_inc)
third_wave <- data.frame(country, cabinet, lr_pg, la_pg, sm_pg, lr_ch, la_ch, sm_ch, wave3_stringency, intensive_care_units, wave3_inc)

main_merged <- merge(main, debt_filtered)

str(main_merged)
main_merged$intensive_care_units <- as.numeric(main_merged$intensive_care_units)
main_merged$debt_share_on_gdp <- as.numeric(main_merged$debt_share_on_gdp)
