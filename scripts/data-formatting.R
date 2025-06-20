# list datasets

df_paths <- list.files(
  "dfs",  # change to folder name containing CSVs with responses
  full.names = TRUE, 
  pattern = "*.csv"
)

# read in all data to list

list_df <- lapply(df_paths, read.csv)

# specify prompt numbers for questions with ratings

ind_rated <- 25:70

# function to select only last response to each of the rated questions

filter_responses <- function(x) {
  x |> dplyr::group_by(
    dataset, 
    rater, 
    prompt_number
  ) |>
    dplyr::summarise(
      rating = dplyr::last(rating),
     response = dplyr::last(response)
   ) |>
    dplyr::filter(
      prompt_number %in% ind_rated
    ) 
}

# apply function across dataframes in list

list_df <- lapply(list_df,
       filter_responses)

# bind data

df_long <- do.call(rbind, list_df)

# pivot data into wide format
## define columns based on rater and dataset.

df_wide <- df_long |>
  tidyr::pivot_wider(
    names_from = c(dataset, rater),
    values_from = c(response, rating)
  )
