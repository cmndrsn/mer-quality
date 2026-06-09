# mer-quality

Quality analysis of MER datasets

## Qualities to be annotated

See [survey-items.md](content/survey-items.md)

## Datasets to be annotated and accompanying metadata

See [datasets.md](content/datasets.md)

See [dataset-metadata.md](content/dataset-metadata.md)

## Dataset rater assignments

See [assignment.md](content/assignment.md)

## Annotation Consistency

See [analysis-plan.md](content/analysis-plan.md)


# Usage
In general, build and run the container. For Apple Silicon Mac, add `--platform=linux/amd64` to the build:
```
docker build --tag 'mer_test' .
docker run --rm -p 3838:3838 mer_test
```
