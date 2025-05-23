---
title: "survey-items"
output: html_document
---

# Item adaptation

## [Priestley et al. (2023)](https://dl.acm.org/doi/10.1145/3592616#core-Bib0003); [Gebru et al. (2019)](https://arxiv.org/pdf/1803.09010)

## Table 3

### Dataset Description

-   **For what purpose was the dataset created?** Was there a specific task in mind? Was there a specific gap that needed to be filled? Please provide a description.

-   **Who created this dataset (e.g., which team, research group) and on behalf of which entity (e.g., company, institution, organization)?**\

-   **What support was needed to make this dataset?** (e.g. who funded the creation of the dataset? If there is an associated grant, provide the name of the grantor and the grant name and number, or if it was supported by a company or government agency, give those details.)\

### Intrinsic

#### Use case & design

-   The paper justifies its selection of human annotators and recruitment methodology (e.g., crowdsourced, experts, psychology students)
-   Reliability of annotations are adequately reported in the paper, or possible to measure from the data (i.e., raw annotations available).
-   The estimated cost of establishing the dataset is reported.
-   The value of the data significant in terms of the cost invested (e.g. over \$5000) or culture-specific expertise.

#### Collection

-   Accuracy can be improved by user-centered approaches for data labeling and augmentation. Examples include recruiting third party to rate emotion where two others disagree, feedback loops between individual and contextual systems, or data collection tools that raise actionable alerts to warn users of unexpected values in advance.
-   (If applicable) Study provides information about screening and training of annotators, if applicable.

#### Cleaning & preprocessing

-   Data entries are unique and redundant cases are removed.
-   Feature complexity is reduced where appropriate to mitigate overfitting or to improve model interpretability
-   Does the study use direct or indirect annotation methods? Direct annotation methods comprise participants ratings, whereas indirect methods include webscraping labels or algorithmic judgments.

#### ML building

-   Completeness of data is improved by enrichment. Examples include demographic data, free-text annotations, mood-control items, musical sophistication measurements.

#### Deployment

-   Validity of data can be ensured through adherence to existing theory, and by checking for representational drift.

### Contextual

#### Use case & design

-   The paper provides the impression features were selected in advance of modeling
-   Data samples are clearly (and convincingly) justified for features selection
-   Data samples are clearly (and convincingly) justified for emotion taxonomies and constructs
-   Data samples are clearly (and convincingly) justified for music stimuli and genre coverage
-   Data samples are clearly (and convincingly) justified for participant source and expertise

#### Collection

-   Context coverage is supported by institutional guidelines on potential power imbalances, ethics and inclusivity
-   The sampling strategy is provided and explained for stimuli
-   The sampling strategy is provided and explained for features
-   The sampling strategy is provided and explained for participants
-   The background of annotators is relevant to the music selection and task design.

#### Cleaning & preprocessing

-   Contextual bias are detected through comparison with suitable reference standards. Examples include real-world representative samples or comparison to previous studies examining similar demographics/musical styles.
-   Data classes are adequately represented and convincingly measure how well the dataset fits the real-world problem.

#### Maintenance

-   Contextually biased data can be addressed using curation, including infrastructure, tools and practices for maintaining nonstatic datasets that grow over time. Examples include a human-centered approach to data collection (e.g., game-ification, retention incentives), a controlled approach to data collection (e.g., consistency in the number of annotators per song), and version control tracking changes to the data.

#### ML building

-   Contextual validity is supported by selecting appropriate features
-   Contextual validity is supported by selecting appropriate emotion taxonomies and constructs
-   Contextual validity is supported by selecting appropriate music stimuli and genres
-   If the dataset contains contextual bias, the training distribution is re-sampled or re-weighted to reduce bias
-   What are the numbers for stimulus N?
-   What are the numbers for stimulus length (median)?
-   What are the numbers for annotator N (if raw data given)? 
-   What are the numbers for domains of data (e.g., annotations, audio, lyrics, features, videos, movement, tags, etc.)?

#### Verification & testing

-   Contextual fit of the model is assessed using benchmarked evaluation
-   Evaluation metrics are verified by checking overlap between training and test datasets

### Representational

#### Use case & design

-   Documentation on user requirements and dataset design are clear and provide the impression of credibility
-   Where data domains (annotations, music, lyrics, tags, features) come from is clearly explained

#### Collection

-   The data collection process is clearly documented (e.g., using datasheets, checklists)
-   Annotation constructs are defined clearly to mitigate inaccuracies in human annotations
-   The annotation scheme adheres to the theory it follows and can it be interpreted by others in the same way
-   What annotation framework is used? (affective circumplex, affect quadrants, basic emotions, aesthetic emotions, other)

#### Cleaning & preprocessing

-   Code is clearly documented.
-   Publicly available code (where applicable) is clearly commented.
-   Data sourced from heterogeneous sources are adequately reformatted, normalised or aggregated for the predictive task.
-   The response apparatus provides participants with options to differentiate ratings for difficult cases, or to express uncertainty/inapplicability of an emotion label. Possible examples toward this goal include granular rating scales, confidence ratings, free-text responses, or the option to opt out of rating excerpts if uncertain.
-   How data domains (annotations, music, lyrics, tags, features) were processed is clearly explained

#### Maintenance

-   Maintainability at scale is supported by standards
-   Clarity of the dataset is supported by user interfaces for dataset exploration
-   Clarity of the metadata is supported by documentation on data content
-   Clarity of the metadata is supported by documentation on the maintenance plan
-   Clarity of the metadata is supported by documentation on the mission statement

#### ML building

-   Clarity of the ML building process are elucidated using model reproducibility checklists or by embedding structured meta-knowledge into the documentation.
-   Clarity of model performance is supported by documentation on evaluation metrics and statistics

#### Verification & testing

-   Transparency of the model can be supported by sensitivity testing and explanations

#### Deployment

-   Interpretability of the model output is supported by explanations

### Accessibility

#### Use case & design

-   Availability of data can be supported by infrastructure for data collection and management (particularly in large organisations)

#### Collection

-   Institutional frameworks and procedures for consent, transparency, ethics and privacy are followed

#### Cleaning & preprocessing

-   Security of sensitive data is supported by anonymisation

#### Maintenance

-   Availability of data is facilitated by infrastructure for differential access and sharing
-   Identifiability of the correct dataset (out of multiple versions) is guided by version control and DOIs
-   The documentation and instructions (specific wording that the annotators saw) for the annotation task are available
-   The data description is fully covered in the documentation for the amount of data
-   The data description is fully covered in the documentation for the selected genre(s)
-   The data description is fully covered in the documentation for the domains of data
-   The data description is fully covered in the documentation for annotator expertise and culture
-   The data description is fully covered in the documentation for the annotation task
-   The data description is fully covered in the documentation for the excerpt duration
-   The data description is fully covered in the documentation for the source where available

#### ML building

-   Code and data are published in a trusted repository and associated with a DOI

#### Verification & testing

-   Test data annotations are publicly available
-   If parts of the data (music, lyrics, album covers, etc) are copyrighted, computerized data is accessible with reasonable effort.
