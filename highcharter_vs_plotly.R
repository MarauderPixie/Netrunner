# tooltip dataframe
plays <- score %>% 
  filter(Seite == "Konzern") %>% 
  count(Fraktion, ID) %>% 
  transmute(plays = paste(paste0(n, "x"), ID),
            Reihe = 1:length(plays)) %>% 
  spread(Fraktion, plays)

list(plays$`Haas Bioroid`, plays$Jinteki, plays$NBN, plays$`Weyland Consortium`)

## better yet:
plays <- score %>% 
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
  plot_ly(bla, x = Fraktion, y = n, name = "Fraktionen", type = "bar",
          marker = list(color = c("darkorchid", "red", "gold", "darkolivegreen")),
          text   = bla)

text   = str_replace_all(IDs, ",", "<br />"))
