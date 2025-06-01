# define a simple progress tracker

progress_bar <- function(items_answered, items_total) {
  if(items_answered > items_total) items_answered <- items_total
  pct_done <- round(items_answered/items_total * 10)
  paste0(
    c(
      "Progress ",
      rep('*', times = pct_done), 
      rep('.', times = 10 - pct_done)), 
    collapse = ""
  )
}