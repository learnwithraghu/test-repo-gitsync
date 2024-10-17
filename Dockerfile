FROM apache/airflow:2.6.3-python3.9

COPY requirements.txt requirements.txt

USER root

# Install GDAL and related dependencies
RUN apt-get update && \
    apt-get install -y gdal-bin libgdal-dev python3-gdal python3-pip python3-dev build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set GDAL environment variables
RUN export CPLUS_INCLUDE_PATH=/usr/include/gdal && \
    export C_INCLUDE_PATH=/usr/include/gdal && \
    export GDAL_VERSION=$(gdal-config --version) && \
    export GDAL_CONFIG=/usr/bin/gdal-config

USER airflow

# Declare the ARG for credentials content
ARG GOOGLE_APPLICATION_CREDENTIALS_CONTENT

# Set the ENV for the path where the credentials file will be located inside the container
ENV GOOGLE_APPLICATION_CREDENTIALS=/opt/airflow/application_default_credentials.json

# Write the credentials content to the specified location
RUN echo "$GOOGLE_APPLICATION_CREDENTIALS_CONTENT" > $GOOGLE_APPLICATION_CREDENTIALS

# Install Fiona and GeoPandas
RUN pip3 install --upgrade pip && \
    pip3 install fiona geopandas

# Install requirements
RUN pip3 install -r requirements.txt

# Install the custom package
RUN pip3 install keyrings.google-artifactregistry-auth
