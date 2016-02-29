# Packages
    # library(readr)        # txt-Dateien einlesen
    library(dplyr)        # für einfacheren Umgang mit Dataframes (wie z.B. ngo)
    library(ggplot2)      # auch Daten wollen hübsch sein
    library(tidyr)        # schnell und einfach Dataframes manipulieren; kann gather()
    library(broom)        # macht mit tidy() sowas wie lm() und t.test() lesbarer
    library(RColorBrewer) # hübsche Daten noch hübscher machen
    library(pixiedust)    # sprinkle() ALL the tables!
    library(googlesheets) # importing ALL the sheets!
    library(ggthemes)     # making them pretty plots even prettier
    library(viridis)      # best color palette, hands down
    library(rmdformats)   # look at them beautiful templates!

# Daten einlesen
    liga  <- gs_title("Netrunner Liga") %>% gs_read()
    score <- gs_title("Netrunner Highscore") %>% gs_read()
    # liga  <- read_csv("./Liga.csv")
    
    
# Runner / Konzern Aufteilung
    runner  <- score %>% filter(Seite == "Runner")
    konzern <- score %>% filter(Seite == "Konzern")
    
    
# Farben definieren
    # mit APEX und Shapern
    # faction_color <- scale_fill_manual(values = c("darkorange", "deepskyblue3", "darkorchid4", "red", 
    #                                               "gold1", "darkgray", "chartreuse3", "darkolivegreen"))
    faction_fill <- scale_fill_manual(values = c("darkorange", "deepskyblue3", "darkorchid4", "red", 
                                                  "gold1", "chartreuse3", "darkolivegreen"))
    kon_fill     <- scale_fill_manual(values = c("darkorchid4", "red", "gold1", "darkolivegreen"))
    run_fill     <- scale_fill_manual(values = c("darkorange", "deepskyblue3", "chartreuse3"))
    
    
# plot cosmetics
cosmetics <- theme_few() +
             theme(title = element_text(size = 14),
                   axis.text    = element_text(size = 12),
                   legend.title = element_text(size = 12),
                   legend.text  = element_text(size = 10),
                   strip.text   = element_text(size = 14))
