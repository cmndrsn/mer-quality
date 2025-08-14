assign_dfs <- function(
    n_df = 21,
    n_rater = 5,
    n_rater_df = 3 # raters per dataframe
) {
  n_df_rater <- floor((n_df*n_rater_df)/n_rater) # dataframes per rater
  message("Each rater evaluates ", n_df_rater, " datasets")
  # represent each dataset 3 times
  assignments <- rep(LETTERS[1:n_df], each = n_rater_df)
  # identify each assignment uniquely
  assignments <- paste0(assignments, 1:n_rater_df)
  # define raters
  raters <- paste0("R", 1:n_rater)
  # create empty list to store dataset assignments
  rating_list <- list()
  # loop through raters
  for(this_rater in raters) {
    # assign 12 dataset evaluations
    rating_list[[this_rater]] <- sample(assignments, n_df_rater)
    # make sure each rater doesn't get the same dataset twice
    while(
      !all(
        summary(
          as.factor(
            substr(
              rating_list[[this_rater]], 
              1, 
              1
            )
          )
        ) == 1)) {
      rating_list[[this_rater]] <- sample(assignments, n_df_rater)
      
    }
    # keep track of which datasets have been assigned and remove from assignment array
    assignments <- assignments[!assignments %in% rating_list[[this_rater]]]
    message("Assigned ", this_rater)
    rating_list[[this_rater]] <- substr(rating_list[[this_rater]], 1, 1)
  }
  return(rating_list)
}

tmp <- assign_dfs()

# return results as data frame
tmp <- data.frame(
  rater = rep(1:5, each = 12),
  df = unlist(tmp)
)

source('lib/get-datasets.R')

tmp$df <- factor(tmp$df)
levels(tmp$df) <- mer_data

# sort by dataframe and assign each rater a role (two raters, one tiebreaker)
tmp <- tmp[order(tmp$df),]
tmp$role <- c('r', 'r', 't')

View(tmp)
