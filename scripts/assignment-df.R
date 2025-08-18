set.seed(1)
# Assign each rater 12 unique datasets ----------------------------

raters <- c("CA", "TE", "JGC", "XH", "VA")

assign_dfs <- function(
    n_df = 21,
    n_rater_df = 3, # raters per dataframe
    seed = 1
) {
  set.seed(seed)
  n_rater <- length(raters)
  # store the number of datasets each rater must evalaute
  n_df_rater <- floor((n_df*n_rater_df)/n_rater) # dataframes per rater

  # create empty list to store dataset assignments
  rating_list <- list()
  
  message("Each rater evaluates ", n_df_rater, " datasets")
  # represent each dataset 3 times
  assignments <- rep(LETTERS[1:n_df], each = n_rater_df)
  # identify each assignment uniquely
  assignments <- paste0(assignments, 1:n_rater_df)

  # loop through raters
  for(this_rater in raters) {
    # assign 12 dataset evaluations
    rating_list[[this_rater]] <- sample(assignments, n_df_rater)
    # make sure each rater doesn't get the same dataset twice
    # if they do, keep resampling until they don't
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

df <- assign_dfs()

# return results as data frame
df <- data.frame(
  dataset = unlist(df)
) |>
  tibble::rownames_to_column('rater') 
# remove digits from rater column
df$rater <- df$rater |> 
  stringr::str_remove(pattern = "\\d+") |>
  as.factor()

# replace placeholder letters with names of datasets

source('lib/get-datasets.R')

df$dataset <- factor(df$dataset)
levels(df$dataset) <- mer_data


# Assign underrepresented datasets --------------------------------

# get under-represented datasets
unassigned <- levels(df$dataset)[summary(df$dataset) < 3]
unassigned <- unassigned[unassigned != "EmoBox (INTERSPEECH)"]

# populate empty list to assign remaining datasets
assignment_list <- list()


# loop through remaining datasets that need to be assigned
for(unassigned_df in unassigned) {
  # sample a rater
  new_rater <- sample(raters, 1)
  # keep resampling until we find a rater who hasn't already been
  # assigned to this dataset
  while(new_rater %in% df[df$dataset == unassigned_df,]$rater) {
    new_rater <- sample(raters, 1)
  }
  new_assignment <- data.frame(rater = new_rater, dataset = unassigned_df)
  # add new assignment to the list of assignments
  assignment_list[[unassigned_df]] <- new_assignment
}

# format newly-assigned datasets

new_assignments <- do.call(rbind, assignment_list)

# add them to the dataset of assignments

df <- rbind(df,
  new_assignments
)

# sort by dataframe and assign each rater a role (two raters, one tiebreaker)
df <- df[order(df$dataset),]


# Define tiebreakers --------------------------------------------------

# expand out raters to match number of dataframes
rater_long <- rep(
  unique(df$rater), 
  each = floor(length(unique(df$dataset))/length(unique(df$rater)))
)

# account for mismatch in length of raters and data (not divisible)
set.seed(1)
rater_long <- c(rater_long, 
  sample(
  rater_long, 
  size = length(unique(df$dataset)) - length(rater_long)
  )
) |>
  sort()


# first, prepare a temporary version of the datasets that can be reduced
tmp <- df
# record all datasets
dfs <- df$dataset |> unique()
# create empty arrays recording assigned dfs, raters, along with 
# an empty dataframe which will record new assignments
df_assigned <- c()
rater_assigned <- c()
tiebreaker_df <- data.frame()
# loop through the raters
for(this_rater in unique(rater_long)) {
  # if last rater, simply assign remaining datasets
  if(this_rater == dplyr::last(unique(rater_long))) {
    tiebreaker_df <- rbind(
      tiebreaker_df,
      data.frame(
        dataset = df_remaining,
        tiebreaker = this_rater
      )
    )
    message("Assigned ", this_rater)
  } else {
    # otherwise, count how many assignments this rater needs
  len_rater <- 4#length(rater_long[rater_long == this_rater])
  # sample len_rater datasets that this rater evaluated
  df_sampled <- sample(
    subset(tmp, rater == this_rater)$dataset, 
    size = len_rater
  )
  # record which datasets got assigned
  df_assigned <- c(df_assigned, as.character(df_sampled))
  # record which rater got assigned
  rater_assigned <- c(rater_assigned, this_rater)
  # update the tiebreaking dataframe with this assignmnet
  tiebreaker_df <- rbind(
    tiebreaker_df, 
    data.frame(
      dataset = df_sampled,
      tiebreaker = this_rater
    )
  )
  # check how many datasets remain
  df_remaining <- setdiff(dfs, df_assigned)
  # check how many raters remain
  rater_remaining <- setdiff(unique(rater_long), rater_assigned)
  # update our temporary df to exclude assigned raters and datasets
  tmp <- dplyr::filter(tmp, 
                dataset %in% df_remaining,
                rater %in% rater_remaining)
  message("Assigned ", this_rater)
  }
}


df <- dplyr::left_join(df, tiebreaker_df)

 # double check assigned tiebreaker actually evaluated dataset
df <- df |>
  dplyr::group_by(
    dataset
  ) |>
  dplyr::mutate(check = tiebreaker %in% rater)
# subset mismatches
tmp <- df[df$check == FALSE,]
# replace tiebreaker assignment 
tmp$tiebreaker <- sample(tmp$rater, 1)
df <- df[df$check == TRUE,]
df <- rbind(df, tmp)
df$check <- NULL

# summarize rater coverage
summary(df$rater)
summary(as.factor(df$tiebreaker))

# summarize dataset coverage
summary(df$dataset)

df |> 
  knitr::kable() |>
  writeLines(con = "content/assignment.md")
