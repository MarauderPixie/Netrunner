# Heatmaps of games played against whom

protoplays <- as.data.frame.matrix(crossprod(table(score$Spiel, score$Spieler)))

hs_plays <- protoplays %>% 
  gather(Spieler, Spiele, Bjarne, Bodo, Falk, Jan, 
         Johannes, Josh, `Josh R.`, Kai, Paul, Tobias) %>% 
  mutate(Gegner = rep(c("Bjarne", "Bodo", "Falk", "Jan",
                        "Johannes", "Josh", "`Josh R.`", 
                        "Kai", "Paul", "Tobias"), 10))


## Test
ggplot(hs_plays, aes(x = Spieler, y = Gegner, fill = Spiele)) + 
  geom_tile(color = "white", size = 0.4)

## filter player == Gegner

if {Spieler == Gegner} {
  
}



# beim gathern der systeme entstehen mehr n als es tatsächlich gibt;
# Problem: means zB fallen zu klein aus
systeme <- runner_liga %>%
  gather(Systeme, Runzahl, Archiv, `R&D`, HQ, Remote) %>% 
  mutate(Runzahl = car::recode(Runzahl, "0 = NA")) %>% 
  group_by(Spieler, Systeme) %>% 
  summarize("Runs" = sum(Runzahl, na.rm = T),
            "Auftreten" = n(),
            "mean" = mean(Runzahl, na.rm = T))