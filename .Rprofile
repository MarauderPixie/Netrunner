## Print this on start so I know it's loaded.
cat("Loading custom .Rprofile")  


### Startup
startup <- function(){
  version     <- R.Version()
  date_string <- Sys.Date()
  ddate       <- ddateR::poee()

  msg1 <- sprintf("Oh, it's you again. Hi! \nThis is %s.
                  \n%s \nLet's crunch some numbers!",
                  version$version.string, "(", version$nickname, ")",
                  ddate)
  cat(msg1, "\n")
}

startup()
rm(startup)


### Packages
suppressPackageStartupMessages(library("devtools"))
suppressPackageStartupMessages(library("ddateR"))
