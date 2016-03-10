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
library(plotly)
library(stringr)

### kurvige graphen <3 (Seite)
score %>% 
  group_by(Kalenderwoche, Seite) %>% 
  summarize("Wins" = sum(Punkte)/2) %>% 
  plot_ly(., x = Kalenderwoche, y = Wins, line = list(shape = "spline"),
          color = Seite, colors = c("blue", "red"), text = unique(Spieler))

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
  score %>%
    group_by(Kalenderwoche, Spieler) %>% 
    summarize("Wins" = sum(Punkte)/2,
              "IDs"  = paste(unique(ID), collapse = ",")) %>%
    plot_ly(., x = Kalenderwoche, y = Wins, line = list(shape = "spline"),
            color = Spieler, text = str_replace_all(IDs, ",", "<br />")) %>% 
      layout(., yaxis = list(rangemode = "tozero"))

  #### heatmap // geht so...
  liga %>% 
    filter(Seite == "Runner", Spieler != "Jannis") %>% 
    gather(Systeme, Runzahl, Archiv, `R&D`, HQ, Remote) %>% 
    plot_ly(., x = Spieler, y = Systeme, z = Runzahl, 
            type = "heatmap", colors = viridis(512))
  
  #### bars, just bars
  konzern %>% 
    group_by(Fraktion) %>% 
    summarize("n" = n(),
              "IDs"  = paste(unique(ID), collapse = ",")) %>% 
    plot_ly(., x = Fraktion, y = n, name = "Fraktionen", type = "bar",
            marker = list(color = c("darkorchid", "red", "gold", "darkolivegreen")),
            text   = str_replace_all(IDs, ",", "<br />"))
  
  #### fancy mit counts
  hover <- konzern %>% 
    group_by(Fraktion, ID) %>% 
    summarize("n" = n())
  
  konzern %>% 
    group_by(Fraktion, ID) %>% 
    summarize("n" = n()) %>% 
    plot_ly(., x = Fraktion, y = n, name = "Fraktionen", type = "bar",
            marker = list(color = c("darkorchid", "red", "gold", "darkolivegreen")),
            hoverinfo = "text",
            text   = list(group = Fraktion, paste(paste0(n, "x"), ID)))
    
    #### zweiter ansatz:
    konzern %>% 
      group_by(Fraktion) %>% 
      summarize("n" = n(),
                "IDs"  = paste(paste0(n, "x"), unique(ID), collapse = ",")) %>% 
      plot_ly(., x = Fraktion, y = n, name = "Fraktionen", type = "bar",
              marker = list(color = c("darkorchid", "red", "gold", "darkolivegreen")),
              text   = str_replace_all(IDs, ",", "<br />"))
    
    
# Why ploty when you can highcharter?
  library(highcharter)
    
    hchart(score$Fraktion, color = c("#FF8C00", "#009ACD", "#68228B", "#FF0000", 
                                     "#FFD700", "#66CD00", "#556B2F"))