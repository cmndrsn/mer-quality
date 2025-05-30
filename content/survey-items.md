---
title: "survey-items"
output: html_document
---

# Item adaptation

## [Priestley et al. (2023)](https://dl.acm.org/doi/10.1145/3592616#core-Bib0003); [Gebru et al. (2019)](https://arxiv.org/pdf/1803.09010)
<!-- heading left blank for formatting purposes-->
###

#### Introduction

- In this interactive module, you will be asked to annotate and evaluate the quality of open-access data used in Music Emotion Recognition (MER) studies. The module uses questions adapted from two highly influential papers in the Data Quality literature by  Priestley et al. (2023) and Gebru et al. (2019), either adapting or directly adopting questions in an effort to improve documentation surrounding MER datasets.
- In the first stage, you will be asked to fill in information surrounding the creators and design of the dataset. These questions come from Datasheets for Datasets by Gebru et al. (2019). In a second stage, you will be asked to rate several data quality dimension items on a scale from 1 = completely disagree to 5 = completely agree.

#### Definitions

- You will evaluate datasets along four data quality (DQ) dimensions: Intrinsic, Contextual, Representational, and Accessibility DQ.
- Intrisic Data Quality has traditionally been understood to reflect the extent to which data values conform to the actual or true values; this includes specific requirements such as accuracy, provenance and cleanliness, the latter of which covers practices such as the addressing missing values and redundant cases. Besides the usual data qualities needed for statistical analysis (e.g., addressing missing data, anomalies), an intrinsic quality that is increasingly valued by ML practitioners and regulators relates to data lineage and traceability.
- Contextual Data Quality relates to the extent to which data are pertinent to the task of the data user; this includes dimensions such as relevance, timeliness, completeness and appropriateness. An essential question that is considered here is the extent to which the sample of cases contained in the dataset diverges from the true distribution of cases that are likely to be encountered when the ML model is deployed. Possible sources of divergence may include historical time or geographic representation.
- Representational Data Quality refers to the extent to which data are presented in an intelligible and clear manner, including requirements such as being interpretable, easy to understand, and represented concisely and consistently. In practical terms, these qualities can be implemented through practices such as standardisation and documentation. Standardisation refers to conventions for capturing information in a consistent manner, including machine-readable data structures and formats for capturing specific attributes (e.g., date, location, measurement error). This helps engineers to ingest datasets from multiple sources and build interoperable solutions. Documentation about the dataset provides an additional layer of descriptive information to support the creation of ML applications.
- Accessibility Data Quality refers to the extent to which data are available, obtainable and secure. The rise of big data and ML applications in recent decades has been accompanied by calls for publishing datasets in an open manner, as well as secure access mechanisms for restricted datasets, so that their value can be realised. For ML stakeholders who work with personal or commercially sensitive data, advances in the accessibility of data have been tempered by security and legal precautions (e.g., compliance with GDPR and intellectual property rights).

### Datasheet

#### Dataset Description

-   For what purpose was the dataset created? Was there a specific task in mind? Was there a specific gap that needed to be filled? Please provide a description.
-   Who created this dataset (e.g., which team, research group) and on behalf of which entity (e.g., company, institution, organization)?
-   What support was needed to make this dataset? (e.g. who funded the creation of the dataset? If there is an associated grant, provide the name of the grantor and the grant name and number, or if it was supported by a company or government agency, give those details.)
-   What is the stimulus N?
-   What is the stimulus length (median)?
-   What is the number of annotators (if raw data given)? 
-   What are the data domains (e.g., annotations, audio, lyrics, features, videos, movement, tags, etc.)?

### Intrinsic

#### Use case & design

-   The paper justifies its selection of human annotators and recruitment methodology (e.g., crowdsourced, experts, psychology students)
-   Reliability of annotations is adequately reported in the paper, or possible to measure from the data (i.e., raw annotations available).
-   The estimated cost of establishing the dataset is reported.
-   The value of the data significant in terms of the cost invested (e.g. over \$5000) or culture-specific expertise.

#### Collection

-   Accuracy can be improved by user-centered approaches for data labeling and augmentation. Examples include recruiting third party to rate emotion where two others disagree, feedback loops between individual and contextual systems, or data collection tools that raise actionable alerts to warn users of unexpected values in advance.
-   (If applicable) Study provides information about screening and training of annotators.

#### Cleaning & preprocessing

-   Data entries are unique and redundant cases are removed.
-   Feature complexity is reduced where appropriate to mitigate overfitting or to improve interpretability
-   Does the study use direct or indirect annotation methods? Direct annotation methods comprise participants ratings, whereas indirect methods include web scraping labels or algorithmic judgments.

#### ML building

-   Completeness of data is improved by enrichment. Enrichment examples include demographic data, free-text annotations, mood-control items, musical sophistication measurements.

#### Deployment

-   Validity of data can be ensured through adherence to existing theory, and by checking for representational drift.

### Contextual

#### Use case & design

-   The paper provides the impression features were selected in advance of modeling
-   The strategy for feature selection is clearly justified
-   The strategy for selecting emotion taxonomies and constructs is clearly justified 
-   The strategy for selecting music stimuli and genres is clearly justified
-   The strategy for sampling participants and relevant information (e.g., gender, culture, expertise) is clearly justified
-   The background of annotators is relevant to the music selection and task design.

#### Collection

-   Context coverage is supported by guidelines on potential power imbalances, ethics and inclusivity

#### Cleaning & preprocessing

-   If the dataset contains contextual biases, the training distribution is resampled to reduce bias and increase comparability to existing reference standards. Examples include real-world representative samples or comparison to previous studies examining similar demographics/musical styles.
-   Data classes are adequately represented and convincingly measure how well the dataset fits the real-world problem.

#### Maintenance

-   Contextually biased data can be addressed using curation, including infrastructure, tools and practices for maintaining nonstatic datasets that grow over time. Examples include a human-centered approach to data collection (e.g., game-ification, retention incentives), a controlled approach to data collection (e.g., consistency in the number of annotators per song), or version control tracking changes to the data.

#### ML building

-   Contextual validity is supported by selecting appropriate features
-   Contextual validity is supported by selecting appropriate emotion taxonomies and constructs
-   Contextual validity is supported by selecting appropriate music stimuli and genres

#### Verification & testing

-   Contextual fit of the model is assessed using benchmarked evaluation
-   The authors offer training and test data splits so that evaluation metrics can be verified transparently

### Representational

#### Use case & design

-   ~~Documentation on user requirements and dataset design are clear and provide the impression of credibility~~
-   Where data domains (annotations, music, lyrics, tags, features) come from is clearly explained

#### Collection

-   The data collection process is clearly documented (e.g., using datasheets, checklists)
-   Annotation constructs are defined clearly to mitigate inaccuracies in human annotations
-   The annotation scheme adheres to the theory it follows and can it be interpreted by others in the same way
-   What annotation framework is used? (affective circumplex, affect quadrants, basic emotions, aesthetic emotions, other)

#### Cleaning & preprocessing

-   Publicly available notebooks or scripts (where applicable) are clearly commented.
-   Data sourced from heterogeneous sources are adequately reformatted, normalised or aggregated.
-   The response apparatus provides participants with options to differentiate ratings for difficult cases, or to express uncertainty/inapplicability of an emotion label. Possible examples toward this goal include granular rating scales, confidence ratings, free-text responses, or the option to opt out of rating excerpts if uncertain.
-   How data domains (annotations, music, lyrics, tags, features) were processed is clearly documented

#### Maintenance

-   Clarity of the dataset is supported by user interfaces for dataset exploration

#### ML building

-   ~~Clarity of the ML building process is elucidated using model reproducibility checklists or by embedding structured meta-knowledge into the documentation.~~
-   ~~Clarity of model performance is supported by documentation on evaluation metrics and statistics~~

### Accessibility

#### Use case & design

-   ~~Availability of data can be supported by infrastructure for data collection and management (particularly in large organisations)~~

#### Collection

-   Research integrity frameworks and procedures for consent, transparency, ethics and privacy are reported

#### Cleaning & preprocessing

-   Security of sensitive data is supported by anonymisation (where applicable)

#### Maintenance

-   Availability of data is facilitated by infrastructure for timely sharing
-   Identifiability of the correct dataset (out of multiple versions) is guided by version control and DOIs
-   The documentation and instructions (specific wording that the annotators saw) for the annotation task are available
-   The data description is fully covered in the documentation for the amount of data
-   The data description is fully covered in the documentation for the selected genre(s)
-   The data description is fully covered in the documentation for the domains of data
-   The data description is fully covered in the documentation for annotator expertise and culture
-   The data description is fully covered in the documentation for the excerpt duration
-   The data description is fully covered in the documentation for the source where available

#### Verification & testing

-   Test data annotations are publicly available
-   If parts of the data (music, lyrics, album covers, etc) are copyrighted, pre-calculated features are accessible with reasonable effort.

### 

#### Debrief
- Thank you for your time. Further reading: Wang, R. Y., & Strong, D. M. (1996). Beyond accuracy: What data quality means to data consumers. Journal of management information systems, 12(4), 5-33. Gebru, T., Morgenstern, J., Vecchione, B., Vaughan, J. W., Wallach, H., Iii, H. D., & Crawford, K. (2021). Datasheets for datasets. Communications of the ACM, 64(12), 86-92.

#### TODO

Define what we mean by documentation (details about trusted repos, etc.)

Terms:
- Trusted repository
- Documentation
- Pre-calculated features
- Have baseline models been applied? (bonus Q)?