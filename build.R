# Collect output files

out_docs   <- c(list.files(pattern = "*.html"))
out_assets <- c("assets", "highscore-plots", "liga-plots")


# Copy files to btsync directory

out_dir <- "~/Dokumente/btsync/tobi.tadaa-data.de/Netrunner"

sapply(out_docs,   file.copy, to = out_dir, overwrite = T, recursive = F)
sapply(out_assets, file.copy, to = out_dir, overwrite = T, recursive = T)