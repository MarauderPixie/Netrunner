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


SDs <- seq(1, 21, by = 1)

ggplot(data = NULL, aes(x = -8:8)) + 
  stat_function(fun = dnorm, geom = "density", args = list(mean = 0, sd = 1), color = "black") +
  stat_function(fun = dnorm, geom = "density", args = list(mean = 0, sd = 3), color = "red") +
  stat_function(fun = dnorm, geom = "density", args = list(mean = 0, sd = 5), color = "green") +
  stat_function(fun = dnorm, geom = "density", args = list(mean = 0, sd = .5), color = "blue") +
  
  theme_tufte()

SDs <- data.frame(xx  = c(-10:10),
                  SD1 = rnorm(21, 0, 1),
                  SD3 = rnorm(21, 0, 3),
                  SD5 = rnorm(21, 0, 5),
                  SD0.5 = rnorm(21, 0, 0.5)) %>% 
       gather(SD, Wert, SD1, SD3, SD5, SD0.5)

anim <- ggplot(SDs, aes(x = -10:10, frame = SD))


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
gg_animate_save(anim, "~/Sysrun.gif", interval = 0.8, ani.width = 640)



## mb sth actually informative
 
plt <-
ggplot(liga, aes(x = Spieler, y = Runs, color = Spieler, 
                 frame = Spiel, cumulative = T)) +
  geom_point(position = "jitter") +
  stat_summary(fun.y = "mean", fun.ymax = "mean", fun.ymin = "mean", 
               colour = "black", size = 0.5, geom = "errorbar") +
  geom_hline(yintercept = mean(liga$Runs, na.rm = T), size = 1, color = "gray") +
  labs(x = NULL, y = "Runs") + 
  scale_color_brewer(palette = "Set1") +
  cosmetics + theme(legend.position = "none")

anim <- gg_animate(plt, interval = 1, ani.width = 640)


### next

plt <- liga %>% 
  filter(Seite == "Runner", Spieler != "Jannis") %>% 
  gather(Systeme, Runzahl, Archiv, `R&D`, HQ, Remote) %>% 
  ggplot(., aes(x = Spieler, y = Systeme, fill = Runzahl,
                frame = Spiel, cumulative = T)) + 
  geom_tile(color = "white", size = 0.4) +
  labs(title = "Runs pro Spieler und System",
       x = NULL, y = NULL) +
  scale_fill_viridis(option = "D") +
  cosmetics + 
  theme(legend.position = "bottom")