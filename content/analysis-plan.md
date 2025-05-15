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



## Intraclass correlation coefficient

The Intraclass Correlation Coefficient (ICC) is a common measure of **inter-rater agreement** for continuous ratings and assesses:

- The **consistency** or **agreement** of quantitative measurements made by multiple observers measuring the same quantity.
- The **proportion of total variance** attributable to differences between the targets (not the raters).

There are multiple forms of ICC depending on:

- Whether the raters are considered **random** or **fixed effects**.
- Whether you want **consistency** or **absolute agreement**.
- Whether you’re averaging multiple raters or assessing individual ratings.

We'll use a common variant:
> **ICC(2,1)** – Two-way random effects, single measurement, absolute agreement.

Here is an implementation on R based on ChatGPT **(to be revised)**:

```
icc_2_1 <- function(data) {
  data <- as.matrix(data)
  n <- nrow(data)  # subjects
  k <- ncol(data)  # raters

  mean_raters <- colMeans(data)
  mean_targets <- rowMeans(data)
  grand_mean <- mean(data)

  # Sum of Squares
  SSR <- sum((mean_raters - grand_mean)^2) * n
  SST <- sum((mean_targets - grand_mean)^2) * k
  residual <- sweep(data, 1, mean_targets, FUN = "-")
  residual <- sweep(residual, 2, mean_raters, FUN = "-")
  SSE <- sum((residual + grand_mean)^2)

  df_target <- n - 1
  df_rater <- k - 1
  df_error <- (n - 1) * (k - 1)

  MSR <- SSR / df_rater
  MST <- SST / df_target
  MSE <- SSE / df_error

  icc <- (MST - MSE) / (MST + (k - 1) * MSE + (k / n) * (MSR - MSE))
  return(icc)
}

```

## Krippendorff's Alpha

This document describes a Python implementation of **Krippendorff's alpha**, a statistical measure of inter-rater reliability (see `content/krippendorff.py`).

Krippendorff’s alpha is used to assess the level of agreement among annotators or raters, accounting for chance agreement. It can handle:
- Missing data
- Different measurement levels: nominal, ordinal, interval, and ratio

The Python function `alpha()` computes Krippendorff’s alpha using either:

1. A matrix of **raw reliability data** (M raters-rows × N items-columns), with `nan` indicating missing ratings.
2. A **value count matrix**: each row represents a unit and columns represent how many coders assigned each value.

The function allows specifying the **level of measurement**, which determines the distance function:

- `'nominal'`: values are treated as unordered categories
- `'ordinal'`: values are ordered
- `'interval'` or `'ratio'`: distances are meaningful (e.g., Likert scales or numerical values)

Here is an implementation on R based on ChatGPT **(to be revised)**:

```
kripp_alpha <- function(value_counts, level = "interval", value_domain = NULL) {
  if (is.null(value_domain)) {
    value_domain <- 0:(ncol(value_counts) - 1)
  }

  # Distance matrix based on level of measurement
  distance_matrix <- switch(level,
    nominal = outer(value_domain, value_domain, function(x, y) as.numeric(x != y)),
    ordinal = {
      ranks <- rank(value_domain)
      outer(ranks, ranks, function(x, y) (x - y)^2)
    },
    interval = outer(value_domain, value_domain, function(x, y) (x - y)^2),
    ratio = outer(value_domain, value_domain, function(x, y) ((x - y)^2) / (x + y)),
    stop("Unsupported level")
  )

  # Coincidence matrix
  o <- matrix(0, length(value_domain), length(value_domain))
  for (i in 1:nrow(value_counts)) {
    row <- value_counts[i, ]
    m <- sum(row)
    if (m > 1) {
      for (v in 1:length(value_domain)) {
        for (w in 1:length(value_domain)) {
          o[v, w] <- o[v, w] + row[v] * (row[w] - ifelse(v == w, 1, 0)) / (m - 1)
        }
      }
    }
  }

  # Expected coincidences under independence
  n_v <- colSums(o)
  n <- sum(n_v)
  e <- outer(n_v, n_v, function(i, j) i * j / (n - 1))

  # Calculate Do and De
  Do <- sum(o * distance_matrix)
  De <- sum(e * distance_matrix)

  if (De == 0) return(0)

  alpha <- 1 - (Do / De)
  return(alpha)
}
```


