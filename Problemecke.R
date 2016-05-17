# beim gathern der systeme entstehen mehr n als es tatsächlich gibt;
# Problem: means zB fallen zu klein aus
systeme <- runner_liga %>%
  gather(Systeme, Runzahl, Archiv, `R&D`, HQ, Remote) %>% 
  mutate(Runzahl = car::recode(Runzahl, "0 = NA")) %>% 
  group_by(Spieler, Systeme) %>% 
  summarize("Runs" = sum(Runzahl, na.rm = T),
            "Auftreten" = n(),
            "mean" = mean(Runzahl, na.rm = T))