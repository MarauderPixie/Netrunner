konzerne <- score %>% 
  filter(Seite == "Konzern") %>% 
  count(Fraktion)

kon_ids  <- score %>% 
  filter(Seite == "Konzern") %>% 
  count(Fraktion, ID)


hb <- paste(paste0(
  filter(kon_ids, Fraktion == "Haas Bioroid")$n, "x"),
  filter(kon_ids, Fraktion == "Haas Bioroid")$ID, collapse = ",")

jt <- paste(paste0(
  filter(kon_ids, Fraktion == "Jinteki")$n, "x"),
  filter(kon_ids, Fraktion == "Jinteki")$ID, collapse = ",")

nbn <- paste(paste0(
  filter(kon_ids, Fraktion == "NBN")$n, "x"),
  filter(kon_ids, Fraktion == "NBN")$ID, collapse = ",")

wl <- paste(paste0(
  filter(kon_ids, Fraktion == "Weyland Consortium")$n, "x"),
  filter(kon_ids, Fraktion == "Weyland Consortium")$ID, collapse = ",")


konzerne %>% 
  mutate(p = n/sum(n)*100,
         "IDs" = c(hb, jt, nbn, wl)) %>% 

plot_ly(., x = Fraktion, y = n, name = "Fraktionen", type = "bar",
        marker = list(color = c("darkorchid", "red", "gold", "darkolivegreen")),
        text   = str_replace_all(IDs, ",", "<br />"))