# tooltip dataframe
id_plays <- score %>% 
  filter(Seite == "Konzern") %>% 
  count(Fraktion, ID) %>% 
  transmute(plays = paste(paste0(n, "x"), ID),
            Reihe = 1:length(plays)) %>% 
  spread(Fraktion, plays)

list(plays$`Haas Bioroid`, plays$Jinteki, plays$NBN, plays$`Weyland Consortium`)

## better yet:
id_plays <- score %>% 
  filter(Seite == "Konzern") %>% 
  count(Fraktion, ID) %>% 
  mutate(plays = paste(paste0(n, "x"), ID),
         Reihe = 1:length(plays)) %>% 
  summarize(n     = sum(n),
            plays = paste(plays, collapse = "<br>"))


## in highcharter:
highchart() %>% 
  # hc_chart(type = "column") %>% 
  hc_title(text = "Konzern Fraktionen") %>% 
  hc_xAxis(categories = plays$Fraktion) %>%
  hc_yAxis(title = list(text = "Spiele")) %>% 
  hc_add_series(data = plays$n, name = "Spiele", colorByPoint = TRUE, type = "column") %>% 
  hc_add_series(data = plays$plays, type = NULL) %>% 
  hc_tooltip(headerFormat = "<b>{point.key}:</b> <br> <table>",
             # pointFormat = "{plays.point.y}",
             footerFormat = "<br><b>Gesamt:</b> {point.y} Spiele </table>",
             #valueSuffix = plays$plays, 
             shared = F) %>% 
  hc_legend(enabled = FALSE) %>% 
  hc_colors(colors = kon_cols)


## in plotly:
  plot_ly(id_plays, x = Fraktion, y = n, name = "Fraktionen", type = "bar",
          marker = list(color = c("darkorchid", "red", "gold", "darkolivegreen")),
          text   = plays)

text   = str_replace_all(IDs, ",", "<br />")

  ggplotly(
    ggplot(score, aes(x = Fraktion, fill = Fraktion)) +
      geom_bar(color = faction_cols, alpha = 0.6) +
      labs(x = "", y = "Spiele") +
      facet_grid(. ~ Seite, scales = "free_x") +
      faction_fill + cosmetics +
      theme(legend.position = "none")
  )
  
  
## fancy polar charts in plotly:
  p <- plot_ly(plotly::wind, r = r, t = t, color = nms, type = "area") %>% 
  layout(., radialaxis = list(ticksuffix = "%"), orientation = 270)
  
  sys_runs <- runner_liga %>% 
    filter(Spieler != "Jannis", Spieler != "Jan") %>% 
    gather(Systeme, Sysruns, Archiv, `R&D`, HQ, Remote) %>% 
    group_by(Spieler, Systeme) %>% 
    summarize(Sysruns = sum(Sysruns, na.rm = T)) %>% 
    ggplot(aes(x = Spieler, y = Systeme, fill = Sysruns)) + 
      geom_tile(color = "white", size = 0.4) +
      labs(title = "Runs pro Spieler und System",
           x = NULL, y = NULL) +
      scale_fill_viridis(option = "D") +
      cosmetics + 
      theme(legend.position = "bottom")
  
  plot_ly(sys_runs, r = Sysruns, t = Systeme, color = Spieler, type = "area",
          opacity = 0.7, name = "Systeme") 

