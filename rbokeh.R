## rbokeh ##
library(rbokeh)

figure() %>%
  ly_points(Sepal.Length, Sepal.Width, data = iris,
            color = Species, glyph = Species,
            hover = list(Sepal.Length, Sepal.Width))

figure(title = "Häufigkeiten pro Fraktion", ylab = "Anzahl", xlab = NULL,
       xgrid = F, tools = NULL, legend_location = NULL) %>% 
  ly_bar(Fraktion, data = liga, color = Fraktion, alpha = 0.95,
         hover = ID, fill_color = cols, line_color = "black")


mittelrun <- runner_liga %>% group_by(Spieler) %>% summarize(Mittel = mean(Runs))

figure(title = "Runs pro Spieler", ylab = "Runs", xlab = NULL, tools = NULL,
       xgrid = F, ygrid = F, legend_location = NULL) %>% 
  ly_lines(x = Spieler, y = mean(runner_liga$Runs), data = runner_liga,
           color = "gray", alpha = 0.8) %>% 
  ly_points(Spieler, Runs, data = runner_liga, hover = "als @ID gegen @Gegner",
            glyph = "diamond", color = Fraktion, size = 15) %>% 
  ly_points(Spieler, Mittel, data = mittelrun, glyph = "x", color = Spieler, size = 20)