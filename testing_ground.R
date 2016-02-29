liga %>% 
  filter(Seite == "Runner", Spieler != "Jannis") %>% 
  gather(Systeme, Runzahl, Archiv, `R&D`, HQ, Remote) %>% 
  ggplot(., aes(x = Spieler, y = Systeme, fill = Runzahl)) + 
    geom_tile(color = "white", size = 0.1) +
    labs(title = "Runs pro Spieler und System",
         x = "",
         y = "") +
    scale_fill_viridis() +
    theme_tufte() + 
    theme(legend.position = "bottom")


theme_few() +
theme(title = element_text(size = 14),
      axis.text    = element_text(size = 12),
      legend.title = element_text(size = 12),
      legend.text  = element_text(size = 10))


plot <- score %>%
  group_by(Kalenderwoche, Seite) %>% 
  summarize("Wins" = sum(Punkte)/2) %>% 
  ggplot(., aes(x = Kalenderwoche, y = Wins, group = Seite, color = Seite)) +
    geom_point() +
    geom_smooth() +
    scale_color_brewer(palette = "Set1") +
    scale_x_continuous(breaks = 1:max(score$Kalenderwoche)) +
    scale_y_continuous(breaks = 1:13) +
    cosmetics

ggplotly(plot)



plot <- liga %>% 
  filter(Seite == "Runner", Spieler != "Jannis") %>% 
  gather(Systeme, Runzahl, Archiv, `R&D`, HQ, Remote) %>% 
  ggplot(., aes(x = Spieler, y = Systeme, fill = Runzahl)) + 
  geom_tile(color = "white", size = 0.4) +
  labs(title = "Runs pro Spieler und System",
       x = NULL, y = NULL) +
  scale_fill_viridis(option = "B") +
  cosmetics + 
  theme(legend.position = "bottom")



liga %>% 
  filter(Seite == "Konzern") %>% 
  ggplot(aes(x = ID, fill = Fraktion)) +
    geom_bar(color = "black") +
    labs(x = "", y = "Spiele", legend = "") +
    facet_grid(. ~ Fraktion, scales = "free") +
    scale_fill_manual(values = c("darkorchid4", "red", "gold1", "darkolivegreen")) +
    cosmetics +
    theme(axis.text.x = element_text(angle = 25, hjust = 0, vjust = 1),
          legend.position = "none")