# Load in custom response function

source("lib/psychTestR.R")

# Read in spreadsheet

df_qualimer <- read.csv(
  file = "data/quality-survey-items.csv"
)

# filter by response type

items_introduce <- dplyr::filter(
  df_qualimer,
  task == "introduce"
)

items_debrief <- dplyr::filter(
  df_qualimer,
  task == "debrief"
)

items_annotate <- dplyr::filter(
  df_qualimer,
  task == "annotate"
)

items_evaluate <- dplyr::filter(
  df_qualimer,
  task == "evaluate"
)

# create module for prompting answers 

## This function will be used in a module for providing
## text responses using psychTestR.


response_next <- function(
  object
) {
  one_button_custom(
    body = object
  )
}

response_annotate <- function(
    object
) {
  text_rating_page(
    include_rating = FALSE,
    prompt = object,
    one_line = FALSE,
    sprintf("Please evaluate %s in the textbox below",
            object)
  )
}

## This function will be used in a module for evaluating
## dataset quality dimensions

response_evaluate <- function(
  object
) {
  text_rating_page(
    include_rating = TRUE,
    prompt = object,
    sprintf("Please evaluate %s in the textbox below",
            object)
  )
}


# Create modules for evaluation survey ----------------------------

introduction_module <- psychTestR::module(
  label = "module_introduction",
  lapply(
    items_introduce$prompt,
    response_next
  )
)

debrief_module <- psychTestR::module(
  label = "module_debrief",
  lapply(
    items_debrief$prompt,
    response_next
  )
)

datasheets_module <- psychTestR::module(
  label = "module_data_sheets",
  lapply(
    items_annotate$prompt, 
    response_annotate
  )
)


evaluation_module <- psychTestR::module(
  label = "module_data_quality",
  lapply(
    items_evaluate$prompt, 
    response_evaluate
  )
)



timeline <- psychTestR::join(
  introduction_module,
  psychTestR::one_button_page("You have now begun Stage 1. 
    Please complete the following prompts
    to fill in a datasheet about the current dataset"
  ),
  datasheets_module,
  psychTestR::one_button_page("You have now begun Stage 2. 
    Please complete the following prompts
    to evaluate quality items for the dataset"
  ),
  evaluation_module,
  psychTestR::elt_save_results_to_disk(complete = TRUE),
  debrief_module,
  psychTestR::final_page("Thank you for completing the survey.")
)

psychTestR::make_test(
  timeline,
  opt = psychTestR::test_options(
    title = "MER Quality Evaluation",
    admin_password = 'test'
  )
)
