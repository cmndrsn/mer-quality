
generate_defs <- function(text_string, lookup_dictionary) {
  label <- ''
  text_string <- tolower(text_string)
  key_terms <- stringr::str_extract_all(
    text_string, 
    names(lookup_dictionary)
  ) |> 
    unlist() |> 
    unique()
  for(this_term in key_terms) {
    label <- paste(
      label, 
      lookup_dictionary[[this_term]],
      '\n\n'
    )
  }
  return(label)
}