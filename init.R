## toolbox readyfication
library(tidyverse)
library(broom)
# library(plotly)     
# library(highcharter)
library(sjPlot)
library(pixiedust)
library(formattable)
library(waffle)
library(viridis)


## set options and stuff
knitr::opts_chunk$set(echo = F, warning = F, message = F, fig.align = "center")

source("./theme_tut.R")
theme_set(theme_tut())
  

## define colors
faction_fill <- scale_fill_manual(values = c("darkorange", "deepskyblue3", "darkorchid4", "red", 
                                             "gold1", "chartreuse3", "darkolivegreen"))
kon_fill     <- scale_fill_manual(values = c("darkorchid4", "red", "gold1", "darkolivegreen"))
run_fill     <- scale_fill_manual(values = c("darkorange", "deepskyblue3", "chartreuse3"))
  
  
kon_cols     <- c('#68228B', '#FF0000', '#FFD700', '#556B2F')
run_cols     <- c("#FF8C00", "#009ACD", "#66CD00")
  
faction_cols <- c("#FF8C00", "#009ACD", '#68228B', '#FF0000', 
                  '#FFD700', "#66CD00", '#556B2F')