#PARLGOV scales----
lr_pg <- c(lr_wm_ita, lr_wm_de, lr_wm_esp, lr_wm_gb, lr_wm_sw)
sm_pg <- c(sm_wm_ita, sm_wm_de, sm_wm_esp, sm_wm_gb, sm_wm_sw)
la_pg <- c(la_wm_ita, la_wm_de, la_wm_esp, la_wm_gb, la_wm_sw)

#CHESSDATA scales----
lr_ch <- c(lr_ch_ita, lr_ch_de, lr_ch_esp, lr_ch_gb, lr_ch_sw)
sm_ch <- c(sm_ch_ita, sm_ch_de, sm_ch_esp,sm_ch_gb,sm_ch_sw )
la_ch <- c(la_ch_ita, la_ch_de, la_ch_esp, la_ch_gb, la_ch_sw)

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




#Intensive Care Units----
intensive_care_units<-icu6$Value
#COVID incidence----

wave1_inc <- c(mean(incidencew1_ita$inc_index),
               mean(incidencew1_deu$inc_index),
               mean(incidencew1_esp$inc_index),
               mean(incidencew1_uk$inc_index),
               mean(incidencew1_sw$inc_index))

wave2_inc <- c(mean(incidencew2_ita$inc_index),
               mean(incidencew2_deu$inc_index),
               mean(incidencew2_esp$inc_index),
               mean(incidencew2_uk$inc_index),
               mean(incidencew2_sw$inc_index))

wave3_inc <- c(mean(incidencew3_ita$inc_index),
               mean(incidencew3_deu$inc_index),
               mean(incidencew3_esp$inc_index),
               mean(incidencew3_uk$inc_index),
               mean(incidencew3_sw$inc_index))
#Dataset Building----
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
