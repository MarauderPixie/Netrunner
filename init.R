## toolbox readyfication
library(tidyverse)
library(broom)
# library(plotly)
# library(highcharter)
library(sjPlot)
# library(pixiedust)
library(formattable)
# library(waffle)
library(viridis)


## set options and stuff
knitr::opts_chunk$set(echo = F, warning = F, message = F, fig.align = "center")

source("./assets/theme_tut.R")
theme_set(theme_tut())
  

## define colors
# crim color was "deepskyblue3" before, anarchs was "darkorange", shapers "chartreuse3"
all_colors <- c("#ff6600", "#0062FF", "darkorchid4", "red", 
                "gold1", "darkgray", "#33cc33", "darkolivegreen")
kon_colors <- c("darkorchid4", "red", "gold1", "darkolivegreen")
run_colors <- c("#ff6600", "#0062FF", "darkgray", "#33cc33")
  
## by hexcode  
# kon_cols     <- c('#68228B', '#FF0000', '#FFD700', '#556B2F')
# run_cols     <- c("#FF8C00", "#009ACD", "#66CD00")
  
# faction_cols <- c("#FF8C00", "#009ACD", '#68228B', '#FF0000', 
#                   '#FFD700', "#66CD00", '#556B2F')