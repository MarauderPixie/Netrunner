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
score %>% 
  filter(Seite == "Konzern") %>% 
  transmute(HB = filter(., Fraktion == "Haas"))