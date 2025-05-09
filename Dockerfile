# Base image 
FROM rocker/shiny

# Create directories
RUN mkdir -p /scripts
RUN mkdir -p /lib
RUN mkdir -p /data
RUN mkdir -p /renv
RUN mkdir -p /output

# Install renv
RUN R -e "install.packages('renv', repos = c(CRAN = 'https://cloud.r-project.org'))"

# Copy files required to run app
COPY /scripts/app.R /scripts/app.R 
COPY /lib/psychTestR.R /lib/psychTestR.R
COPY /data/quality-survey-items.csv /data/quality-survey-items.csv

# Install curl dependency
RUN apt-get update && apt-get install -y libssl-dev 
RUN apt-get install -y libcurl4-openssl-dev
CMD /bin/bash

# Manage packages with renv
COPY renv.lock renv.lock
# copy renv files
RUN mkdir -p renv
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json
# restore renv packages
RUN R -e "renv::restore(repos='https://cloud.r-project.org')"

EXPOSE 8080

# Run app
CMD Rscript /scripts/app.R