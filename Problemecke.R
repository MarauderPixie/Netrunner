# beim gathern der systeme entstehen mehr n als es tatsächlich gibt;
# Problem: means zB fallen zu klein aus
systeme <- runner_liga %>%
  gather(Systeme, Runzahl, Archiv, `R&D`, HQ, Remote) %>% 
  mutate(Runzahl = car::recode(Runzahl, "0 = NA")) %>% 
  group_by(Spieler, Systeme) %>% 
  summarize("Runs" = sum(Runzahl, na.rm = T),
            "Auftreten" = n(),
            "mean" = mean(Runzahl, na.rm = T))


# Spielübersichtspilerei
plays <-
as.data.frame.matrix(crossprod(table(score$Spiel, score$Spieler))) %>% 
  gather(Spieler, Spiele, Bjarne, Bodo, Boray, Falk, Jan,
         Johannes, Josh, `Josh R.`, Kai, Ole, Paul, Tobias) %>% 
  mutate(Gegner = rep(c("Bjarne", "Bodo", "Boray", "Falk", "Jan",
                        "Johannes", "Josh", "Josh R.", 
                        "Kai", "Ole", "Paul", "Tobias"), 12)) %>% 
  filter(Spieler != Gegner, Spiele != 0)

sjt.df(plays, describe = F)


# make IDs relative:
# Grundsätzliches Problem: entweder ALLE IDs, egal welcher Konzerne, ergeben 100%,
# so dass die Relation stimmt, oder
# die IDs jedes Kons sind für sich 100%, dann sticht zB HB nicht mehr so raus, aber 
# die Relationen stimmen nicht mehr

  # Problem: Kon und Runner ergeben zusammen(!) 100% 
  ggplot(score, aes(x = Fraktion, fill = Fraktion)) +
    geom_bar(aes(y = (..count..) / sum(..count..) * 100),
             color = "black", alpha = 0.8) +
    labs(x = "", y = "Spiele") +
    facet_grid(. ~ Seite, scales = "free_x") +
    faction_fill +
    cosmetics + theme(legend.position = "none")