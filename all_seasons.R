## Create data containing all seasons (old and new format)
# rationale: it's easier to shape the old data like the new one
alt <- readRDS("./data/Liga_alt.rds") %>% 
  filter(Saison  != 4, 
         Spieler != "Jannis") %>% 
  mutate(Spieler = recode(Spieler, "Tobias" = "Tobi"))
neu <- readRDS("./data/Liga.rds") %>% 
  filter(Runner_Player != "Stefan", Konzern_Player != "Stefan")


## create two dfs (runner & corp), rename columns like in the new data,
## clean up a little and tadaa, finished! Maybe?
run <- alt %>% 
  filter(Seite == "Runner") %>% 
  mutate(index = seq_along(Saison)) %>% 
  rename(
    "Runner_Player" = Spieler, "Runner_Fraktion" = Fraktion,
    "Runner_ID" = ID, "Runner_Mulligan" = Mulligan, "Archive" = Archiv,
    "RnD" = `R&D`, "Runner_Agendapunkte" = Agendapunkte, "Konzern_ID" = Gegner_ID,
    "Konzern_Player" = Gegner_Spieler, "Konzern_Fraktion" = Gegner_Fraktion
  )

kon <- alt %>% 
  filter(Seite == "Konzern") %>% 
  mutate(index = seq_along(Saison)) %>% 
  rename(
    "Konzern_Mulligan"     = Mulligan, 
    "Konzern_Agendapunkte" = Agendapunkte
  ) %>% 
  select(Konzern_Mulligan, Konzern_Agendapunkte, index)

alt2 <- left_join(run, kon, by = "index") %>% 
  mutate(
    Sieger_Seite   = ifelse(Punkte == 0, "Konzern", "Runner"),
    Sieger_Spieler = ifelse(Punkte == 0, Konzern_Player, Runner_Player)
  ) %>% 
  select(-index, -Punkte, -Runde, - Schnitt_Zug, -Seite, -Spiel)


## combine alt & neu
complete <- full_join(alt2, neu)
rm(alt, alt2, kon, neu, run)

saveRDS(complete, "./data/Liga_complete.rds")