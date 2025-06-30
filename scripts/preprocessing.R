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
ind_final <- which(survey_items$prompt == "Please click next without editing this page. You will be able to revise your responses on the next page.")

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
  '12' = c("Yes", "No"), 
  '13' = c("Direct", "Indirect"),
  '15' = c("Yes", "No")
)

 ind_mc_options <- list(
   '14' = c("Affective Circumplex", "Affect Quadrants", "Basic Emotions", "Aesthetic Emotions", "Other")
 )

# definitions for tooltips
 
 definitions <- list(
   trusted = "A Trusted Digital Repository aims to provide reliable and long-term accessibility to digital resources to its target community (OCLC, 2002, p. 5).",
   documentation = "For the purpose of this questionnaire, the term 'documentation' pertains to information about accessing data and analyses relevant to the dataset in question through a public-facing source, such as an article, preprint, readme, or web page.",
   precalculated = "Precalculated features refers to features that were analyzed prior to data modelling. For example, some datasets include features from audio extraction tools like Essentia, Marsyas, or OpenSMILE.",
   'user-centered' = "Examples of user-centered approaches include recruiting third party to rate emotion where two others disagree, feedback loops between individual and contextual systems, or data collection tools that raise actionable alerts to warn users of unexpected values in advance.",
   enrichment = "Enrichment examples include demographic data, free-text annotations, mood-control items, musical sophistication measurements.",
   drift = "Conceptual drift occurs when the statistical relationships between input data and target values change unpreditably over time (Computer Networks, 2022).",
   'contextual bias' = "Contextual bias refers to a situation when a model's performance hinges on specific contextual features related to the prediction task. For example, an algorithm designed to predict emotion annotations in different kinds of music would contain bias if it was only trained on one genre.",
   'contextually biased' = "Contextual bias refers to a situation when a model's performance hinges on specific contextual features related to the prediction task. For example, an algorithm designed to predict emotion annotations in different kinds of music would contain bias if it was only trained on one genre.",
   'test data' = "For the purpose of this evaluation, we will consider test data an annotated dataset upon which regression/classification can be performed",
   domain = "Data domains refer to distinct data sources relevant for the MER task, such as direct/indirect annotations, metadata, analyzed features, physiological data, etc.",
   'direct or indirect' = "Direct annotation methods comprise participants ratings, whereas indirect methods include web scraping labels or algorithmic judgments."
 )

definitions_dq <- list(
  intrinsic = "Intrinsic Data Quality has traditionally been understood to reflect the extent to which data values conform to the actual or true values; this includes specific requirements such as accuracy, provenance and cleanliness, the latter of which covers practices such as the addressing missing values and redundant cases. Besides the usual data qualities needed for statistical analysis (e.g., addressing missing data, anomalies), an intrinsic quality that is increasingly valued by ML practitioners and regulators relates to data lineage and traceability.",
  contextual = "Contextual Data Quality relates to the extent to which data are pertinent to the task of the data user; this includes dimensions such as relevance, timeliness, completeness and appropriateness. An essential question that is considered here is the extent to which the sample of cases contained in the dataset diverges from the true distribution of cases that are likely to be encountered when the ML model is deployed. Possible sources of divergence may include historical time or geographic representation.",
  representational = "Representational Data Quality refers to the extent to which data are presented in an intelligible and clear manner, including requirements such as being interpretable, easy to understand, and represented concisely and consistently. In practical terms, these qualities can be implemented through practices such as standardisation and documentation. Standardisation refers to conventions for capturing information in a consistent manner, including machine-readable data structures and formats for capturing specific attributes (e.g., date, location, measurement error). This helps engineers to ingest datasets from multiple sources and build interoperable solutions. Documentation about the dataset provides an additional layer of descriptive information to support the creation of ML applications.",
  accessibility = "Accessibility Data Quality refers to the extent to which data are available, obtainable and secure. The rise of big data and ML applications in recent decades has been accompanied by calls for publishing datasets in an open manner, as well as secure access mechanisms for restricted datasets, so that their value can be realised. For ML stakeholders who work with personal or commercially sensitive data, advances in the accessibility of data have been tempered by security and legal precautions (e.g., compliance with GDPR and intellectual property rights)."
)

 
 
 
 