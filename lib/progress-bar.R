# define a simple progress tracker

progress_bar <- function(items_answered, items_total) {
  if(items_answered > items_total) items_answered <- items_total
  pct <- round((items_answered/items_total)*100)
  pt_done <- round(items_answered/items_total * 10)
  paste0(
    c(
      "Progress ",
      rep('#', times = pt_done), 
      rep('-', times = 10 - pt_done),
      " (", pct, "%)"
      ), 
    collapse = ""
  )
}