---
title: "survey-items"
output: html_document
---

# Item adaptation: [Priestley et al. (2023)](https://dl.acm.org/doi/10.1145/3592616#core-Bib0003)
## Table 3
### Intrinsic
#### Use case & design
- The paper justifies its selection of human annotators and recruitment methodology (e.g., crowdsourced, experts, psychology students)
- Reliability of annotations are adequately reported in the paper, or possible to measure from the data (i.e., raw annotations available).
#### Collection
*Unsure how to adapt these items*:
```
Accuracy can be improved by:
Human-in-the-loop approaches for data labelling and augmentation [49, 73].
Data collection tools that raise actionable alerts to warn users of unexpected values in advance [38, 57].
```
- Study provides information about screening and training of annotators, if applicable.
#### Cleaning & preprocessing
- Data entries are unique and redundant cases are removed.
- Feature complexity is reduced where appropriate to mitigate overfitting or to improve model interpretability
- Does the study use data augmentation? (Y/N)
#### Maintenance
[no items in paper]
#### ML building
- Where applicable, uniqueness of features is supported by dimensionality reduction.

*Relevant?*
```
Completeness of data is improved by enrichment.
```
#### Verification & testing
[no items in paper]
#### Deployment

*Possibly address this next point by comparing to baseline models/predictive ceilings:*
```
Validity of serving data can be ensured by following the data preparation rules of the original model, and by checking for representational drift
````
#### Monitoring
[no items in paper]

---

### Contextual
#### Use case & design
- The paper provides the impression features were selected in advance of modeling
- Data samples are clearly (and convincingly) justified:
	- Features
	- Emotion taxonomies and constructs
	- Music stimuli and genre coverage
	- Participant source and expertise
#### Collection
- Context coverage are supported by institutional guidelines on potential power imbalances, ethics and inclusivity
#### Cleaning & preprocessing

*These items can potentially address issues related to annotator demographics:*
```
- Contextual bias are detected using ground-truth correlations
- Data classes are proportionally represented and measuring how well the dataset fits the real-world problem.
```
#### Maintenance
*Does not seem particularly relevant:*
```
Contextually biased data can be improved using curation, including infrastructure, tools and practices for maintaining nonstatic datasets that grow over time 
```
#### ML building
- Contextual validity is supported by selecting appropriate features:
  	- Features
	- Emotion taxonomies and constructs
	- Music stimuli and genre

- If the dataset contains contextual bias, the training distribution is re-sampled or re-weighted to reduce bias.
#### Verification & testing
- Contextual fit of the model is assessed using benchmarked evaluation.
- Evaluation metrics are verified by checking overlap between training and test datasets.
#### Deployment
Seems irrelevant:
```
Contextually sensitive ML options include client-side ML (federated learning)
``` 
#### Monitoring
This item may require some reworking (this is the original text), though still seems relevant.
```
Fidelity of the model in evolving contexts can be monitored by checking the distribution and features of data fed into the model
```

### Representational
#### Use case & design
- Documentation on user requirements and dataset design are clear and provide the impression of credibility
#### Collection
- The data collection process is clearly documented (e.g., using datasheets, checklists)
- Annotation constructs are defined clearly to mitigate inaccuracies in human annotations.

*This also seems promising, may be worth discussing*
```
Consistency of data is improved using standardisation
```
#### Cleaning & preprocessing
- Code is clearly documented.
- Publicly available code (where applicable) is clearly commented.
- Data sourced from heterogeneous sources are adequately reformatted, normalised or aggregated for the predictive task.

*Unsure:*
```
Precision can be improved by using representational standards that allow for uncertainty
```
#### Maintenance
```
Maintainability at scale is supported by standards
```
- Clarity of the dataset is supported by user interfaces for dataset exploration
- Clarity of the metadata is supported by documentation on
	- Data content
	- Maintenance plan
	- Mission statement  
#### ML building
*I think we'd find few studies scoring high in these dimensions:*
- Clarity of the ML building process are elucidated using model reproducibility checklists or by embedding structured meta-knowledge into the documentation.
- Clarity of model performance is supported by documentation on evaluation metrics and statistics 
#### Verification & testing
```
- Clarity of model performance results is improved by model cards, including contextual evaluation results.
```
- Transparency of the model can be supported by sensitivity testing and explanations
#### Deployment
- Interpretability of the model output is supported by explanations
#### Monitoring
[no items]

---
### Accessibility
#### Use case & design
These items seem irrelevant to me
```
- Availability of data can be supported by infrastructure for data collection and management (particularly in large organisations)
- Validity of data for online learning can be assured by putting in place runtime verification tools
```
#### Collection
- Institutional frameworks and procedures for consent, transparency, ethics and privacy are followed
#### Cleaning & preprocessing
- Security of sensitive data is supported by anonymisation
#### Maintenance
- (If applicable) Availability of data is facilitated by infrastructure for differential access and sharing 
- (If applicable) Identifiability of the correct dataset (out of multiple versions) is guided by version control and DOIs 
#### ML building
- Code and data are published in a trusted repository and associated with a  DOI *(I modified the language)*
#### Verification & testing
- Test data is publicly available
Presumably not applicable:
```
Security of restricted training data can be assured by adversarial testing for data poisoning, model stealing and inversion
```
 #### Deployment
 [no items]
#### Monitoring
Presumably not applicable:
```
Security of restricted training data can be assured by monitoring for adversarial attacks 
```

## TODO (discuss): 
- terminology around standards
- degree to which we modify items for relevance to MER
- removal or substitution of items
