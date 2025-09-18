get_unixtime <- function() {
  tryCatch({
    # get time in UTC
    response <- httr::GET("http://worldtimeapi.org/api/timezone/Etc/UTC")
    time_data <- jsonlite::fromJSON(httr::content(response, "text"))
    utc_time <- time_data$unixtime
    
    return(utc_time)
    
  }, error = function(e) {
    cat(conditionMessage(e))
    return(as.numeric(Sys.time()))
  })
}
