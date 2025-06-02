# mer-quality

Quality analysis of MER datasets

## Qualities to be annotated

See [survey-items.md](content/survey-items.md)

## Datasets to be annotated

See [datasets.md](content/datasets.md)

## Annotation Consistency

See [analysis-plan.md](content/analysis-plan.md)


# Usage
In general, build and run the container. For Apple Silicon Mac, add `--platform=linux/amd64:
```
docker build --tag 'mer_test' .
docker run --rm -p 3838:3838 mer_test
```