## the real plotly testing
library(plotly)
library(stringr)

### kurvige graphen <3 (Seite)
score %>% 
  group_by(Kalenderwoche, Seite) %>% 
  summarize("Wins" = sum(Punkte)/2) %>% 
  plot_ly(., x = Kalenderwoche, y = Wins, type = "bar",
          color = Seite, colors = c("blue", "gray", "red"), text = unique(.$Spieler))


### kurvige graphen mit ID-Hovertext <3 (Spieler)
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
    summarize("Spiele" = n(),
              "IDs"  = paste(unique(ID), collapse = ",")) %>% 
    plot_ly(., x = Fraktion, y = Spiele, name = "Fraktionen", type = "bar",
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
    
    # Reihenfolge:
    # Anarch, Criminals, Haas, Jinteki, NBN(, Neutral), Shaper, Weyland
    faction_fill_hex <- c("#FF8C00", "#009ACD", "#68228B", "#FF0000", 
                          "#FFD700", "#66CD00", "#556B2F")
    
    kon_cols <- c('#68228B', '#FF0000', '#FFD700', '#556B2F')
    run_cols <- c("#FF8C00", "#009ACD", "gray", "#66CD00")
    
    konzerne <- score %>% filter(Seite == "Konzern") %>% group_by(Fraktion) %>% summarize(n = n())
    kon_ids  <- score %>% filter(Seite == "Konzern") %>% group_by(Fraktion, ID) %>% summarize(n = n())
    runner   <- score %>% filter(Seite == "Runner") %>% group_by(Fraktion) %>% summarize(n = n())
    run_ids  <- score %>% filter(Seite == "Runner") %>% group_by(Fraktion, ID) %>% summarize(n = n())
    
    highchart() %>% 
      hc_chart(type = "column") %>% 
      hc_title(text = "Fraktionen") %>% 
      hc_xAxis(categories = konzerne$Fraktion) %>%
      hc_yAxis(title = list(text = "Spiele")) %>% 
      hc_add_series(data = konzerne$n, name = "Spiele", colorByPoint = TRUE) %>% 
      hc_legend(enabled = FALSE) %>% 
      hc_colors(colors = kon_cols)
    
    highchart() %>% 
      hc_chart(type = "column") %>% 
      hc_title(text = "Fraktionen") %>% 
      hc_xAxis(categories = runner$Fraktion) %>%
      hc_yAxis(title = list(text = "Spiele")) %>% 
      hc_add_series(data = runner$n, name = "Spiele", colorByPoint = TRUE) %>% 
      hc_legend(enabled = FALSE) %>% 
      hc_colors(colors = run_cols)