definitions <- list(
  intrinsic = "Intrinsic Data Quality has traditionally been understood to reflect the extent to which data values conform to the actual or true values; this includes specific requirements such as accuracy, provenance and cleanliness, the latter of which covers practices such as the addressing missing values and redundant cases. Besides the usual data qualities needed for statistical analysis (e.g., addressing missing data, anomalies), an intrinsic quality that is increasingly valued by ML practitioners and regulators relates to data lineage and traceability.",
  contextual = "Contextual Data Quality relates to the extent to which data are pertinent to the task of the data user; this includes dimensions such as relevance, timeliness, completeness and appropriateness. An essential question that is considered here is the extent to which the sample of cases contained in the dataset diverges from the true distribution of cases that are likely to be encountered when the ML model is deployed. Possible sources of divergence may include historical time or geographic representation.",
  representational = "Representational Data Quality refers to the extent to which data are presented in an intelligible and clear manner, including requirements such as being interpretable, easy to understand, and represented concisely and consistently. In practical terms, these qualities can be implemented through practices such as standardisation and documentation. Standardisation refers to conventions for capturing information in a consistent manner, including machine-readable data structures and formats for capturing specific attributes (e.g., date, location, measurement error). This helps engineers to ingest datasets from multiple sources and build interoperable solutions. Documentation about the dataset provides an additional layer of descriptive information to support the creation of ML applications.",
  accessibility = "accessibility Data Quality refers to the extent to which data are available, obtainable and secure. The rise of big data and ML applications in recent decades has been accompanied by calls for publishing datasets in an open manner, as well as secure access mechanisms for restricted datasets, so that their value can be realised. For ML stakeholders who work with personal or commercially sensitive data, advances in the accessibility of data have been tempered by security and legal precautions (e.g., compliance with GDPR and intellectual property rights).",
  trusted = "A Trusted Digital Repository aims to provide reliable and long-term accessibility to digital resources to its target community (OCLC, 2002, p. 5).",
  documentation = "For the purpose of this questionnaire, the term 'documentation' pertains to information about accessing data and analyses relevant to the dataset in question through a public-facing source, such as an article, preprint, readme, or web page.",
  precalculated = "Precalculated features refers to features that were analyzed prior to data modelling. For example, some datasets include features from audio extraction tools like Essentia, Marsyas, or OpenSMILE.",
  'human-in-the-loop' = "This is the definition for human-in-the-loop approaches",
  enrichment = "Enrichment examples include demographic data, free-text annotations, mood-control items, musical sophistication measurements.",
  drift = "Definition!",
  contextual = "Definition!"
)

return_def <- function(text_string, lookup_dictionary) {
  label <- ''
  text_string <- tolower(text_string)
  key_terms <- stringr::str_extract_all(
    text_string, 
    names(lookup_dictionary)
    ) |> 
    unlist() |> 
    unique()
  for(this_term in key_terms) {
    print(this_term)
    label <- paste(
      label, 
      lookup_dictionary[[this_term]],
      '\n'
    )
  }
  return(label)
}



