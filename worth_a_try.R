plotlyfy <- function(df, x) {
    paste(paste0(
      filter(df, Fraktion == df$x)$n, "x"),
      filter(df, Fraktion == df$x)$ID, collapse = ",")
}




c <- for (i in konzerne$Fraktion) {
  paste(paste0(
    filter(kon_ids, Fraktion == i)$n, "x"),
    filter(kon_ids, Fraktion == i)$ID, collapse = ",")
}



konzerne %>% 
  mutate(times_played = paste0(n, "x"),
         )


plotify <- function(data, var) {
  data %>% 
    group_by(Seite, Fraktion) %>% 
    mutate(n = n(),
           p = n / sum(n) * 100)
    mutate(times = paste0(n, "x")) %>% 
    summarize()
}






# wenn highcharts arrays benutzt:
  hb <- score %>% filter(Fraktion == "Haas Bioroid")

# hicharter(blablubb) %>% 
#   tooltip(hb$ID)
# ...oder so



# tooltip dataframe
bla <- score %>% 
  filter(Seite == "Konzern") %>% 
  count(Fraktion, ID) %>% 
  mutate(plays = paste(paste0(n, "x"), ID),
         Reihe = 1:length(plays)) %>% 
  summarize(n   = sum(n),
            bla = paste(plays, collapse = "<br>"))

# und dit nu in highcharter:
highchart() %>% 
  hc_chart(type = "column") %>% 
  hc_title(text = "Konzern Fraktionen") %>% 
  hc_xAxis(categories = bla$Fraktion) %>%
  hc_yAxis(title = list(text = "Spiele")) %>% 
  hc_add_series(data = bla$n, name = "Spiele", colorByPoint = TRUE) %>% 
  hc_tooltip(headerFormat = "<b>{point.key}:</b> <br> <table>",
             pointFormat = "{this.point.key}",
             footerFormat = "<b>Gesamt:</b> {point.y} Spiele <table />") %>% 
  hc_legend(enabled = FALSE) %>% 
  hc_colors(colors = kon_cols)