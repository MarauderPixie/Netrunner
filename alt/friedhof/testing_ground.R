# Heatmaps of games played against whom

protoplays <- as.data.frame.matrix(crossprod(table(score$Spiel, score$Spieler)))

hs_plays <- protoplays %>% 
  gather(Spieler, Spiele, Bjarne, Bodo, Falk, Jan, 
         Johannes, Josh, `Josh R.`, Kai, Paul, Tobias) %>% 
  mutate(Gegner = rep(c("Bjarne", "Bodo", "Falk", "Jan",
                        "Johannes", "Josh", "`Josh R.`", 
                        "Kai", "Paul", "Tobias"), 10)),
         logic  = (Spieler == Gegner),
         test   = car::recode(.$Spiele[hs_plays$Spieler == hs_plays$Gegner], 
                              "TRUE = NA; FALSE = 'bla'"))

hs_plays$Spiele[hs_plays$Spieler == hs_plays$Gegner] <- TRUE
  
  car::recode(hs_plays$Spiele[hs_plays$Spieler == hs_plays$Gegner], 
                    "TRUE = NA; FALSE = 'bla'")


## Test
ggplot(hs_plays, aes(x = Spieler, y = Gegner, fill = Spiele)) + 
  geom_tile(color = "white", size = 0.4)

## filter player == Gegner

if {Spieler == Gegner} {
  
}



# the real plotly testing

## kurvige graphen <3 (Seite)
score %>% 
  group_by(Kalenderwoche, Seite) %>% 
  summarize("Wins" = sum(Punkte)/2) %>% 
  plot_ly(., x = Kalenderwoche, y = Wins, type = "bar",
          color = Seite, colors = c("blue", "gray", "red"), text = unique(.$Spieler))


## kurvige graphen mit ID-Hovertext <3 (Spieler)
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
            text   = str_replace_all(IDs, ",", "<br />"), bgcolor = "#FFFFFF")
  
    
# Why ploty when you can highcharter?
  library(highcharter)
    
    # Reihenfolge:
    # Anarch, Criminals, Haas, Jinteki, NBN(, Neutral), Shaper, Weyland
    faction_fill_hex <- c("#FF8C00", "#009ACD", "#68228B", "#FF0000", 
                          "#FFD700", "#66CD00", "#556B2F")
    
    kon_cols <- c('#68228B', '#FF0000', '#FFD700', '#556B2F')
    run_cols <- c("#FF8C00", "#009ACD", "gray", "#66CD00")
    
    konzerne <- score %>% 
      filter(Seite == "Konzern") %>% 
      group_by(Fraktion) %>% 
      summarize(n = n())
    
    kon_ids  <- score %>% 
      filter(Seite == "Konzern") %>% 
      group_by(Fraktion, ID) %>% 
      summarize(n = n())
    
    runner   <- score %>% 
      filter(Seite == "Runner") %>% 
      group_by(Fraktion) %>% 
      summarize(n = n())
    
    run_ids  <- score %>% 
      filter(Seite == "Runner") %>% 
      group_by(Fraktion, ID) %>% 
      summarize(n = n())
    
    highchart() %>% 
      hc_chart(type = "column") %>% 
      hc_title(text = "Konzern Fraktionen") %>% 
      hc_xAxis(categories = konzerne$Fraktion) %>%
      hc_yAxis(title = list(text = "Spiele")) %>% 
      hc_add_series(data = konzerne$n, name = "Spiele", colorByPoint = TRUE) %>% 
      # hc_tooltip(pointFormat = "{point.y} {series.name}:") %>% 
      hc_legend(enabled = FALSE) %>% 
      hc_colors(colors = kon_cols)
    
    highchart() %>% 
      hc_chart(type = "column") %>% 
      hc_title(text = "Runner Fraktionen") %>% 
      hc_xAxis(categories = runner$Fraktion) %>%
      hc_yAxis(title = list(text = "Spiele")) %>% 
      hc_add_series(data = runner$n, name = "Spiele", colorByPoint = TRUE) %>% 
      # hc_add_series(data = run_ids$n) %>%
      hc_tooltip(pointFormat = "{point.y} {series.name}:") %>% 
      hc_legend(enabled = FALSE) %>% 
      hc_colors(colors = run_cols)
    
    ## heatmap maybe
    highchart() %>% 
      hc_chart(type = "heatmap") %>% 
      hc_add_series(data = big) %>% 
      hc_xAxis(categories = colnames(big))
    
# MOAR heatmaps!
    big <- as.data.frame(crossprod(table(score$Spiel, score$Spieler)))
    
    
    cnt <- as.data.frame.matrix(table(score$Spiel, score$Spieler))
    cnt %>% gather(Spieler, Matches, Bjarne, Bodo, Falk,
                   Jan, Johannes, Josh, Kai, Paul, Tobias)
    
    test <- score %>% 
      select(Runde, Spieler, Spiel) %>% 
      spread(Runde, Spieler)
    
    result <- test %>% count(`1`, `2`)
    
    ggplot(result, aes(x = `1`, y = `2`, fill = n)) + 
      geom_tile(color = "white", size = 0.4) +
      labs(title = "Wer hat wie oft gegen wen gespielt?",
           x = NULL, y = NULL) +
      scale_fill_viridis(option = "D") +
      cosmetics + 
      theme(legend.position = "bottom")
    
    
    
    
    
    highchart() %>% 
      # hc_chart(type = "column") %>% 
      hc_title(text = "Konzern Fraktionen") %>% 
      hc_xAxis(categories = plays$Fraktion) %>%
      hc_yAxis(title = list(text = "Spiele")) %>% 
      hc_add_series(data = plays$n, name = "Spiele", colorByPoint = TRUE, type = "column") %>% 
      hc_add_series(data = plays$plays, name = "IDs") %>% 
      hc_tooltip(headerFormat = "<b>{point.key}:</b> <br> <table>",
                 pointFormat  = "{series.name}: {point.y}<br> ",
                 footerFormat = "<br><b>Gesamt:</b> {point.y} Spiele </table>",
                 #valueSuffix = plays$plays, 
                 shared = T) %>% 
      hc_legend(enabled = FALSE) %>% 
      hc_colors(colors = kon_cols)    
    
    
    
    
    highscore <- score %>% select(Spiel, Spieler)
    
    highscore <- table(highscore$Spiel, highscore$Spieler)
    
    highscore <- as.data.frame.matrix(crossprod(highscore))
  
    
    gradient <- color_tile(viridis(1), viridis(max(highscore)))
    # substr(viridis(max(highscore)), 0, 7)
    
    format_table(highscore, 
                 list(Bjarne = gradient, Bodo = gradient, Falk = gradient,
                      Jan = gradient, Johannes = gradient, Josh = gradient,
                      Kai = gradient, Paul = gradient, Tobias = gradient), 
                 check.rows = T, align = "c", format = "markdown")