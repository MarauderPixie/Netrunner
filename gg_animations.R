library(gganimate)

ani <-
ggplot(score, aes(x = Fraktion, fill = Fraktion, frame = Kalenderwoche)) +
  geom_bar(aes(cumulative = T), color = "black") +
  labs(x = "", y = "Spiele") +
  facet_grid(. ~ Seite, scales = "free_x") +
  faction_fill +
  cosmetics +
  theme(legend.position = "none")

ani <- gg_animate(ani, interval = 0.5)
gg_animate_save(ani, "~/Fraktionen.gif", interval = 0.5)



rows <- data.frame(Kalenderwoche = as.integer(rep(1, 8)), 
                   Fraktion = c("Anarchs", "Criminals", "Haas Bioroid", "Jinteki", 
                                "NBN", "Neutral", "Shaper", "Weyland Consortium"), 
                   n = rep(0, 8), Seite = c("Runner", "Runner", "Konzern", "Konzern", 
                                            "Konzern", "Runner", "Runner", "Konzern"))

mation <- score %>% count(Kalenderwoche, Fraktion, Seite)

mation <- rbind(rows, mation)

anim <-
ggplot(mation, aes(x = Fraktion, fill = Fraktion, frame = Kalenderwoche)) +
  geom_bar(aes(y = n, cumulative = T), stat = "identity") +
  labs(x = "", y = "Spiele", title = "Woche:") +
  facet_grid(. ~ Seite, scales = "free_x") +
  faction_fill +
  cosmetics +
  theme(legend.position = "none")


anim <- gg_animate(anim, interval = 1, ani.width = 640)
gg_animate_save(anim, "~/Fraktionen.gif", interval = 0.8, ani.width = 640)
