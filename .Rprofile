## Print this on start so I know it's loaded.
## cat("Loading custom .Rprofile")  


### Startup
startup <- function(){
  version     <- R.Version()
  date_string <- Sys.Date()
  ddate       <- ddateR::ddate()

  msg1 <- sprintf("Oh, it's you again. Let's crunch some numbers! \nThis is %s.\nToday is %s, %s.\nOr like the Discordians like to say:\n%s",
                  version$version.string,
                  format(date_string, "%A"),
                  date_string,
                  ddate)
  cat(msg1, "\n")
}

startup()
rm(startup)


### Packages
suppressPackageStartupMessages(library("devtools"))
suppressPackageStartupMessages(library("ddateR"))
