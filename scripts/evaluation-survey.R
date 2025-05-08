
# Read in data and functions --------------------------------------

# Load in custom response function

source("lib/psychTestR.R")

# populate with final selection of databases

mer_data <- c(
  "Dataset 1",
  "Dataset 2",
  "Dataset 3"
)

# Read in spreadsheet containing prompts

df_qualimer <- read.csv(
  file = "data/quality-survey-items.csv"
)


# Define behaviour of study phases --------------------------------

# Info text pertaining to introduction

items_introduce <- dplyr::filter(
  df_qualimer,
  task == "introduce"
)

# Info text pertaining to study debrief

items_debrief <- dplyr::filter(
  df_qualimer,
  task == "debrief"
)

# Items participants write responses about (e.g., datasheet writing)

items_annotate <- dplyr::filter(
  df_qualimer,
  task == "annotate"
)

# Items participants evaluate with text and a rating (e.g., DQ category)

items_evaluate <- dplyr::filter(
  df_qualimer,
  task == "evaluate"
)

# Define response functions ---------------------------------------

# Response involves clicking "next", nothing fancy.

response_next <- function(
  object
) {
  one_button_custom(
    body = object
  )
}

# Response involves writing in a text box.

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

# Response involves writing in a textbox and choosing a numeric rating.

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


# Create pages and modules for evaluation survey -----------------------

# define routine to select from options

df_selection <- psychTestR::dropdown_page(
  "dataset-selection", 
  "Please select the dataset you will encode", 
  choices = mer_data
)

# Populate intro module with relevant text prompts

introduction_module <- psychTestR::module(
  label = "module_introduction",
  lapply(
    items_introduce$prompt,
    response_next
  )
)

# Populate debrief module with relevant text prompts

debrief_module <- psychTestR::module(
  label = "module_debrief",
  lapply(
    items_debrief$prompt,
    response_next
  )
)

# Populate datasheet module with relevant text prompts

datasheets_module <- psychTestR::module(
  label = "module_data_sheets",
  lapply(
    items_annotate$prompt, 
    response_annotate
  )
)

# Populate DQ evaluation module with relevant text prompts

evaluation_module <- psychTestR::module(
  label = "module_data_quality",
  lapply(
    items_evaluate$prompt, 
    response_evaluate
  )
)

# Define survey timeline ------------------------------------------

timeline <- psychTestR::join(
  introduction_module,
  df_selection,
  psychTestR::one_button_page(
    "We will now begin Stage 1. 
    Please complete the following prompts
    to fill in a datasheet about the current dataset"
  ),
  datasheets_module,
  psychTestR::one_button_page(
    "We will now start Stage 2. 
    Please complete the following prompts
    to evaluate quality items for the dataset"
  ),
  evaluation_module,
  psychTestR::elt_save_results_to_disk(complete = TRUE),
  debrief_module,
  psychTestR::final_page(
    "Thank you for completing the survey."
  )
)

# Create survey ---------------------------------------------------

psychTestR::make_test(
  timeline,
  opt = psychTestR::test_options(
    title = "MER Quality Evaluation",
    admin_password = 'test'
  )
)
