#11A Govs changes


pgovs <- rio::import(here::here("Dataset/", "cabinet.xlsx"))
party <- rio::import(here::here("Dataset/","party.xlsx"))

#belgium: changes gov in october 2020-----
bel <- pgovs[
  pgovs$country_name_short == "BEL" &
  pgovs$cabinet_name == "De Croo" &
  pgovs$cabinet_party == 1,
]

bel_name <- "De Croo"
bel_2_lr <- weighted.mean(bel$left_right, bel$seats)

belp <- party[
  party$party_name_short == "AGL-Gr" |
    party$party_name_short == "CVP|CD&V" |  
    party$party_name_short == "Ecolo" | 
    party$party_name == "Mouvement Réformateur" | 
    party$party_name == "Parti Socialiste" | 
    party$party_name_short == "PVV|VLD" | 
    party$party_name == "Socialistische Partij" &
    party$country_name_short == "BEL",
    ]

bel_2_la <- weighted.mean(belp$liberty_authority, bel$seats)
bel_2_sm <- weighted.mean(belp$state_market, bel$seats)
bel_share <- sum(bel$seats)/bel$election_seats_total*100
bel_share <- unique(bel_share)

rownames(step3) <- 1:396

step3[c(1:2, 4,6,8,10), 6] <- bel_name
step3[c(1:2, 4,6,8,10), 8] <- bel_2_lr
step3[c(1:2, 4,6,8,10), 9] <- bel_2_sm
step3[c(1:2, 4,6,8,10), 10] <- bel_2_la
step3[c(1:2, 4,6,8,10), 7] <- bel_share





#croatia: changes gov after election in july 2020-----
hrv <- pgovs[
  pgovs$country_name == "Croatia" &
  pgovs$cabinet_name == "Plenkovic III" &
    pgovs$cabinet_party == 1,
]


hrv_name <- "Plenkovic III"
hrv_2_lr <- weighted.mean(hvr$left_right, hvr$seats)

belp <- party[
  party$party_name_short == "AGL-Gr" |
    party$party_name_short == "CVP|CD&V" |  
    party$party_name_short == "Ecolo" | 
    party$party_name == "Mouvement Réformateur" | 
    party$party_name == "Parti Socialiste" | 
    party$party_name_short == "PVV|VLD" | 
    party$party_name == "Socialistische Partij" &
    party$country_name_short == "BEL",
]

bel_2_la <- weighted.mean(belp$liberty_authority, bel$seats)
bel_2_sm <- weighted.mean(belp$state_market, bel$seats)
bel_share <- sum(bel$seats)/bel$election_seats_total*100
bel_share <- unique(bel_share)

rownames(step3) <- 1:396

step3[c(1:2, 4,6,8,10), 6] <- bel_name
step3[c(1:2, 4,6,8,10), 8] <- bel_2_lr
step3[c(1:2, 4,6,8,10), 9] <- bel_2_sm
step3[c(1:2, 4,6,8,10), 10] <- bel_2_la
step3[c(1:2, 4,6,8,10), 7] <- bel_share




