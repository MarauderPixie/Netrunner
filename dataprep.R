## Google Forms data

## toolbox readyfication
library(tidyverse)
library(googlesheets)
library(stringr)
library(broom)


## read and manipulate data
## warnings for multiple column names get suppressed since they get changed immediately afterwards
forms <- suppressWarnings(
  gs_title("Ligaresponses") %>% 
  gs_read() %>% 
  transmute(
    Saison           = ifelse(as.Date(Timestamp, format = "%d/%m/%Y") <= as.Date("2017-06-30"), 4, 5),
    # Spiel            = rep(1:length(X16), each = 2),
    # Runde            = rep(1:2, length(X17)),
    Konzern_Player   = Konzern,
    Konzern_Fraktion = X5,
    Konzern_ID       = coalesce(X14, X15, X16, X17),
    Runner_Player    = Runner,
    Runner_Fraktion  = X4,
    Runner_ID        = coalesce(X6, X7, X8, X9),
    Archive          = `die Archive?`,
    RnD              = `das R&D?`,
    HQ               = `das HQ?`,
    Remote           = `Remotes?`,
    Runs             = Archive + RnD + HQ + Remote,
    Runner_Mulligan  = `Gab es Mulligans? [Runner]`,
    Konzern_Mulligan = `Gab es Mulligans? [Konzern]`,
    Runden           = `Anzahl Runden:`,
    Dauer            = `Dauer (in ganzen Minuten):`,
    Runner_Agendapunkte  = `Agendapunkte Runner`,
    Konzern_Agendapunkte = `Agendapunkte Konzern`,
    Siegbedingung        = `Sieg durch:`,
    Sieger_Seite         = `Sieger:`,
    Sieger_Spieler       = ifelse(Sieger_Seite == "Runner", 
                                  Runner_Player, Konzern_Player)
  )
)


## save to file
saveRDS(forms, "./data/Liga.rds")
