---
title: "analysis-plan"
output: html_document
---

## Step 1. Definition of annotation qualities
See [content/survey-items.md](content/survey-items.md)

## Step 2. Choosing datasets
See [datasets.md](datasets.md)

## Step 3. Annotation Consistency

### 3.1 Resolving factual statements

Definition of a scheme where we resolve any conflicting factual statements about the annotations. For instance, two annotators give different stimulus N, different number of emotion categories, or availability of materials in the annotations.

After the first pass, we could calculate the agreement (as a categorical entity) as % or more sophisticated way using Fleiss' Kappa consistency among the raters.

I suggest that any discrepancies are, however, resolved by finding a **consensus** (annotators go back a resolve the discrepancy and document the issue).

### 3.1 How to determine likert scale agreement

**Consistency**: To assess the inter-rater agreement, we can use ICC (Intraclass Correlation Coefficient), or preferable Omega (McDonald's $\omega$) or Kendall's Concordance (_W_) if we think these are ordinal data and not interval data. Omega is probably the best here.

We define a _protocol_ to address items or areas with low agreement/high inconsistencies:

If the omega is poor (say, <0.50) have either:
a) flag items and the same annotators reannotate the item after discussing the definition (clarification)
b) add a new annotator and evaluate with a new evaluator included. Optionally evaluate after excluding the annotator that is considered an outlier
c) master reviewer approach, where one person (4th person who has not annotated the item makes the final determination)

## Step 4: Score Aggregation

### 4.1 How to aggregate scores

**Aggregation of the scores within areas**: For ratings on a scale of 1-5 for each item, if we have a minimum of three ratings, we can calculate the mean or the median as the aggregated value or even round it up to nearest 0.5 (1.0, 1.5, 2.0, 2.5, etc). These operations can be done at the level of areas of annotations (separate aggregated scores for each area).

**Summary of the scores across areas**: To get a single metric for each dataset, we need to decide if we want to weight any areas or items. We define the weights beforehand and calculate the overall score from the raw means using the weighting and offer either mean score is rounded mean score as a final score.

