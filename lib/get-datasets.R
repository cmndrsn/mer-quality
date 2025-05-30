# Read in dataset markdown file
df_md <- read.delim(
    'content/datasets.md', 
    sep = '\n',
    col.names = 'prompt'
  )

# find headings above and below list of datasets to evaluate
df_ind <- stringr::str_detect(
  df_md$prompt, 
  "### Datasets|## Discarded"
) |>
  which()
# now select all rows between headings
mer_data <- df_md[(df_ind[1]+1):(df_ind[2]-1),]
# extract dataset name from between first set of square brackets
mer_data <- stringr::str_extract(mer_data, "(?<=\\[).+?(?=\\])")
# remove unneeded variables
remove(df_md, df_ind)
