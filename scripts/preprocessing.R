# source dependencies

sapply(
  list.files(
    here::here(
      'lib'
    ),
    full.names = TRUE
  ),
  source
)

# assign datasets to variable

datasets <- mer_data

# get survey questions

survey_items <- survey_items_df()

# exclude disqualified prompts

survey_items <- survey_items[
  !stringr::str_detect(
    survey_items$prompt, 
    "~~"
  ),
]

# remove TODOs

survey_items <- survey_items[!survey_items$category == "TODO",]

# record prompt and category

prompt <- survey_items$prompt
category <- survey_items$category

# add headings based on dimension and category columns

heading <- paste(survey_items$dimension, "-", survey_items$category)
heading <- trimws(sub("^\\s+-*", "", heading))

# track indices for questionnaire items :

ind_rater <- which(survey_items$category %in% c("Input initials"))
ind_dfs <- which(survey_items$category %in% c("Dataset Selection"))
ind_info <- which(survey_items$category %in% c("Introduction", "Definitions", "Debrief"))
ind_textbox <- which(survey_items$dimension %in% c("Datasheet"))
ind_rating <- which(survey_items$dimension %in% 
                      c(
                        "Intrinsic",
                        "Representational",
                        "Contextual",
                        "Accessibility"
                      )
)


# define forced-choice questions
ind_fc <- which(
  stringr::str_detect(
    survey_items$prompt,
    "Is test data publicly available?|Does the study use direct or indirect annotation methods?|baseline models|estimated cost"
  )
)
# define forced choice questions with multiple response options
ind_mc <- which(
  stringr::str_detect(
    survey_items$prompt,
    "What annotation framework"
  )
)

# remove from existing textbox items
ind_textbox <- ind_textbox[!ind_textbox %in% c(ind_fc, ind_mc)]

ind_fc_options <- list(
  '20' = c("Yes", "No"), 
  '21' = c("Direct", "Indirect"),
  '23' = c("Yes", "No")
)

 ind_mc_options <- list(
   '22' = c("Affective Circumplex", "Affect Quadrants", "Basic Emotions", "Aesthetic Emotions", "Other")
 )

