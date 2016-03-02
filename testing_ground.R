## ggplotly testing

plot <- score %>%
  group_by(Kalenderwoche, Seite) %>% 
  summarize("Wins" = sum(Punkte)/2) %>% 
  ggplot(., aes(x = Kalenderwoche, y = Wins, group = Seite, color = Seite)) +
    geom_smooth(se = F) +
    geom_point() +
    scale_color_brewer(palette = "Set1") +
    scale_x_continuous(breaks = 1:max(score$Kalenderwoche)) +
    scale_y_continuous(breaks = 1:13) +
    cosmetics

ggplotly(plot)


## the real plotly testing

### kurvige graphen <3 (Seite)
score %>% 
  group_by(Kalenderwoche, Seite) %>% 
  summarize("Wins" = sum(Punkte)/2) %>% 
  plot_ly(., x = Kalenderwoche, y = Wins, line = list(shape = "spline"),
          color = Seite, colors = c("blue", "red"), text = rownames(unique(Spieler)))

### kurvige graphen <3 (Spieler)
score %>% 
  group_by(Kalenderwoche, Spieler) %>% 
  summarize("Wins" = sum(Punkte)/2) %>% 
  plot_ly(., x = Kalenderwoche, y = Wins, line = list(shape = "spline"),
          color = Spieler, text = rownames(unique(Spieler)))

### kurvige graphen mit ID-Hovertext <3 (Spieler)
score %>% 
  group_by(Kalenderwoche, Spieler) %>% 
  summarize("Wins" = sum(Punkte)/2,
            "IDs"   = list(unique(ID))) %>% 
  plot_ly(., x = Kalenderwoche, y = Wins, line = list(shape = "spline"),
          color = Spieler, text = rownames(IDs))
  
  #### stellt sich raus: gar nicht so einfach
  hover <- score %>% 
            group_by(Kalenderwoche, Spieler) %>% 
            summarize("Wins" = sum(Punkte)/2,
                      "IDs"  = paste(unique(ID), sep = ",")) %>%
            plot_ly(., x = Kalenderwoche, y = Wins, line = list(shape = "spline"),
                    color = Spieler, text = str_replace_all(IDs, ",", "<br />"))
    
  str_replace_all(hover$IDs, ",", "\\n")
  