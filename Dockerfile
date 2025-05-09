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
COPY /scripts/app.R /scripts/app.R 
COPY /lib/psychTestR.R /lib/psychTestR.R
COPY /data/quality-survey-items.csv /data/quality-survey-items.csv

EXPOSE 8080

# Run app
CMD Rscript /scripts/app.R