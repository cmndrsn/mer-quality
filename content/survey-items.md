---
title: "survey-items"
output: html_document
---

# Item adaptation

## [Priestley et al. (2023)](https://dl.acm.org/doi/10.1145/3592616#core-Bib0003); [Gebru et al. (2019)](https://arxiv.org/pdf/1803.09010)

### 

#### Dataset Selection

- Select a dataset.

###

#### Introduction

- In this interactive module, you will be asked to annotate and evaluate the quality of open-access data used in Music Emotion Recognition (MER) studies. The module uses questions adapted from two highly influential papers in the Data Quality literature by  Priestley et al. (2023) and Gebru et al. (2019), either adapting or directly adopting questions in an effort to improve documentation surrounding MER datasets.
- In the first stage, you will be asked to fill in information surrounding the creators and design of the dataset. These questions come from Datasheets for Datasets by Gebru et al. (2019). In a second stage, you will be asked to rate several data quality dimension items on a scale from 1 = completely disagree to 5 = completely agree.
- You will evaluate datasets along four data quality (DQ) dimensions: Intrinsic, Contextual, Representational, and Accessibility DQ.

### Datasheet

#### Motivation & Additional Information

-   What is the number of annotators (if raw data given)? 
-   What are the data domains (e.g., annotations, audio, lyrics, features, videos, movement, tags, etc.)?
-   Is test data publicly available?
-   Does the study use direct or indirect annotation methods? 
-   What annotation framework(s) is/are used?
-   The estimated cost of establishing the dataset is reported.

### Intrinsic

#### Use case & design

-   The paper justifies its selection of human annotators and recruitment methodology (e.g., crowdsourced, experts, psychology students)
-   Reliability of annotations is adequately reported in the paper, or possible to measure from the data (i.e., raw annotations available).
-   If reported, how much did the dataset cost to prepare?
-   The dataset contributes unique insight into cultural differences in MER.

#### Collection

-   Accuracy is improved by user-centered approaches for data labeling/augmentation. 
-   (If applicable) Study provides information about screening and training of annotators.

#### Cleaning & preprocessing

-   Data entries are unique and redundant cases are removed.
-   Feature complexity is reduced where appropriate to mitigate overfitting or to improve interpretability.

#### ML building

-   Completeness of data is improved by enrichment.

#### Deployment

-   Validity of data is ensured through adherence to existing theory, and by checking for representational drift.

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

-   If the dataset contains contextual biases, the training distribution is resampled to reduce bias and increase comparability to existing reference standards. For example, the study might validate their findings through real-world representative samples or comparison to previous studies examining similar demographics/musical styles.
-   Data classes are adequately represented and convincingly measure how well the dataset fits the real-world problem.

#### Maintenance

-   Contextually biased data is addressed using curation, including infrastructure, tools, and practices for maintaining nonstatic datasets that grow over time. Examples include a user-centered approach to data collection (e.g., game-ification, retention incentives), a controlled approach to data collection (e.g., consistency in the number of annotators per song), or version control tracking changes to the data.

#### ML building

-   The selected audio features are contextually valid.
-   The emotion taxonomies and constructs are contextually valid.
-   The music stimuli and genres are contextually valid.

#### Verification & testing

-   Contextual fit of the model is assessed using benchmarked evaluation.
-   The authors offer training and test data splits so that evaluation metrics can be verified transparently.

### Representational

#### Use case & design

-   ~~Documentation on user requirements and dataset design are clear and provide the impression of credibility~~
-   Where data domains (annotations, music, lyrics, tags, features) come from is clearly explained.

#### Collection

-   The data collection process is clearly documented (e.g., using datasheets, checklists).
-   Annotation constructs are defined clearly to mitigate inaccuracies in human annotations.
-   The annotation scheme adheres to the theory it follows and can it be interpreted by others in the same way.

#### Cleaning & preprocessing

-   Publicly available notebooks or scripts (where applicable) are clearly commented.
-   Data sourced from heterogeneous sources are adequately reformatted, normalised or aggregated.
-   The response apparatus provides participants with options to differentiate ratings for difficult cases, or to express uncertainty/inapplicability of an emotion label. Possible examples toward this goal include granular rating scales, confidence ratings, free-text responses, or the option to opt out of rating excerpts if uncertain.
-   How data domains (annotations, music, lyrics, tags, features) were processed is clearly documented.

#### Maintenance

-   Clarity of the dataset is supported by user interfaces for dataset exploration.

#### ML building

-   ~~Clarity of the ML building process is elucidated using model reproducibility checklists or by embedding structured meta-knowledge into the documentation.~~
-   ~~Clarity of model performance is supported by documentation on evaluation metrics and statistics~~

### Accessibility

#### Use case & design

-   ~~Availability of data can be supported by infrastructure for data collection and management (particularly in large organisations)~~

#### Collection

-   Research integrity frameworks and procedures for consent, transparency, ethics and privacy are reported.

#### Cleaning & preprocessing

-   Security of sensitive data is supported by anonymisation (where applicable).

#### Maintenance

-   Availability of data is facilitated by infrastructure for timely sharing.
-   Identifiability of the correct dataset (out of multiple versions) is guided by version control and DOIs.
-   The documentation and instructions (specific wording that the annotators saw) for the annotation task are available.
-   The documentation unambiguously identifies the shape and size of data.
-   The documentation unambiguously outlines the music genre(s) used for MER.
-   The documentation unambiguously outlines the data domains included.
-   The documentation unambiguously outlines annotator expertise and culture.
-   The documentation unambiguously outlines the excerpt duration.
-   The documentation unambiguously outlines the source where the open-access data are available.

#### Verification & testing

-   (If applicable) Test data annotations are accessible with reasonable effort.
-   If parts of the data (music, lyrics, album covers, etc) are copyrighted, precalculated features are accessible with reasonable effort.

### 

#### Review
- Please click next without editing this page. You will be able to revise your responses on the next page.
- Here you can review and edit your responses. Make sure you click "next" once you are finished to ensure your responses save. Updates will be recorded automatically. IMPORTANT: if you responded to an item multiple times, please only edit the row containing your latest response.
- Thank you for your time. You may now close this tab, or make additional changes and click next.

#### TODO

Define what we mean by documentation (details about trusted repos, etc.)

Terms:
- Trusted repository
- Documentation
- Precalculated features
- Have baseline models been applied? (bonus Q)?