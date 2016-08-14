## rbokeh ##
library(rbokeh)

figure() %>%
  ly_points(Sepal.Length, Sepal.Width, data = iris,
            color = Species, glyph = Species,
            hover = list(Sepal.Length, Sepal.Width))

figure(title = "Häufigkeiten pro Fraktion", ylab = "Anzahl", xlab = NULL,
       xgrid = F, tools = NULL, legend_location = NULL) %>% 
  ly_bar(Fraktion, data = liga, color = Fraktion, alpha = 0.95,
         hover = list(Fraktion, ID), fill_color = cols, line_color = "black")