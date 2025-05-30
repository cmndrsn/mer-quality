# Stage 1: base image
FROM rocker/shiny AS base
# Install curl dependency
RUN apt-get update && apt-get install -y libssl-dev 
RUN apt-get install -y libcurl4-openssl-dev
CMD /bin/bash


WORKDIR /project
# set up renv
RUN mkdir -p renv
COPY renv.lock renv.lock
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json

# change default location of cache to project folder
RUN mkdir renv/.cache
ENV RENV_PATHS_CACHE renv/.cache

# Stage 2: renv set-up
FROM base

WORKDIR /project
COPY --from=base /project .


# restore
WORKDIR /project
RUN R -e "renv::restore()"

# Copy files required to run app
RUN mkdir -p lib
RUN mkdir -p content
COPY lib/psychTestR.R lib/psychTestR.R
COPY lib/survey-items-df.R lib/survey-items-df.R
COPY lib/get-datasets.R lib/get-datasets.R
COPY content/survey-items.md content/survey-items.md
COPY content/datasets.md content/datasets.md
COPY app.R app.R 

EXPOSE 3838

# Run app
CMD Rscript app.R