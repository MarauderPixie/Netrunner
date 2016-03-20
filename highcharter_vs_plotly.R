# tooltip dataframe
plays <- score %>% 
  filter(Seite == "Konzern") %>% 
  count(Fraktion, ID) %>% 
  transmute(plays = paste(paste0(n, "x"), ID),
            Reihe = 1:length(plays)) %>% 
  spread(Fraktion, plays)

list(plays$`Haas Bioroid`, plays$Jinteki, plays$NBN, plays$`Weyland Consortium`)


## in highcharter:
highchart() %>% 
  hc_chart(type = "column") %>% 
  hc_title(text = "Konzern Fraktionen") %>% 
  hc_xAxis(categories = konzerne$Fraktion) %>%
  hc_yAxis(title = list(text = "Spiele")) %>% 
  hc_add_series(data = konzerne$n, name = "Spiele", colorByPoint = TRUE) %>% 
  # hc_tooltip(headerFormat = list(hb, jt, nbn, wl)) %>% 
  hc_legend(enabled = FALSE) %>% 
  hc_colors(colors = kon_cols)


## in plotly:
konzern %>% 
  count(Fraktion) %>% 
  plot_ly(., x = Fraktion, y = n, name = "Fraktionen", type = "bar",
          marker = list(color = c("darkorchid", "red", "gold", "darkolivegreen")),
          text   = list(plays$`Haas Bioroid`, plays$Jinteki, plays$NBN, plays$`Weyland Consortium`))

