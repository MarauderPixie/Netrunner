## toolbox readyfication
library(tidyverse)
library(googlesheets)
library(stringr)
library(broom)

## read data, manipulate a little,too
liga <- gs_title("Netrunner Liga") %>% 
  gs_read() %>% 
  mutate("Schnitt_Zug" = (Dauer / Runden))

## split runner and corp data
runner  <- liga %>% filter(Seite == "Runner")
konzern <- liga %>% filter(Seite == "Konzern")

## add opponent column
rl <- runner %>% select(Spieler, Fraktion, ID)
colnames(rl) <- c("Gegner_Spieler", "Gegner_Fraktion", "Gegner_ID")
ll <- konzern %>% select(Spieler, Fraktion, ID)
colnames(ll) <- c("Gegner_Spieler", "Gegner_Fraktion", "Gegner_ID")

runner  <- cbind(runner, ll)
konzern <- cbind(konzern, rl)

rm(rl, ll)

liga <- rbind(runner, konzern)

## save to rds
saveRDS(liga, "./Liga.rds")
saveRDS(runner, "./Runner.rds")
saveRDS(konzern, "./Konzern.rds")