survey_items_2_df <- function(survey_items = 'content/survey-items.md') {
  # read in markdown file:
  df_md <- read.delim(
    survey_items, 
    sep = '\n',
    col.names = 'prompt'
  )
  
  # identify level 3 headings in new column
  df_md$dimension <- stringr::str_extract(
    df_md$prompt,
    "###(.*)$",
  )
  
  # identify level 4 headings in new column
  df_md$category <- stringr::str_extract(
    df_md$prompt,
    "####(.*)$"
  )
  # remove values in "dimension" col where values match "category" col
  df_md$dimension[df_md$dimension == df_md$category] <- NA
  # fill in NAs across dimension and category column
  df_md <- df_md |> tidyr::fill(dimension, category)
  # remove values in "prompt" column that match "category" column
  df_md[!df_md$prompt == df_md[,"category"],]
  # remove hashtags across columns
  df_md <- apply(
    df_md,
    2,
    function(x) trimws(stringr::str_remove_all(x, '#'))
  ) |>
    as.data.frame()
  # remove remaining NAs in dimension column
  df_md <- df_md[!is.na(df_md$dimension),]
  # filter out cases where prompt column matches remaining columns
  df_md <- df_md |> dplyr::filter(
    !df_md$prompt %in% df_md$dimension,
    !df_md$prompt %in% df_md$category
  )

  # remove duplicated values across columns
  df_md <- df_md[!is.na(df_md$dimension) & !is.na(df_md$category),]
  # remove bullet points left over in md file
  df_md$prompt <- trimws(stringr::str_remove_all(df_md$prompt, '- '))
  
  return(df_md)
}