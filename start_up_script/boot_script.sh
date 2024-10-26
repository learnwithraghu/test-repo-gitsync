#!/bin/bash

# Get the directory where the script is located
script_dir=$(dirname "$0")

# Create log file with timestamp
log_file="${script_dir}/logs/airflow_install_$(date +%Y%m%d_%H%M%S).log"

# Function to log messages to both screen and log file
log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$log_file"
}

log "Starting Airflow installation..."

# Create airflow-local directory
log "Creating airflow-local directory..."
mkdir airflow-local
cd airflow-local

# Update apt-get
log "Updating apt-get..."
sudo apt-get update

# Install ca-certificates and curl
log "Installing ca-certificates and curl..."
sudo apt-get install -y ca-certificates curl

# Install apt-keyrings
log "Installing apt-keyrings..."
sudo install -m 0755 -d /etc/apt/keyrings

# Add Docker's GPG key
log "Adding Docker's GPG key..."
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker repository to apt sources
log "Adding Docker repository to apt sources..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update apt-get again
log "Updating apt-get..."
sudo apt-get update

# Install Docker
log "Installing Docker..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Verify Docker installation
log "Verifying Docker installation..."
docker --version
docker compose version

# Create Airflow directories
log "Creating Airflow directories..."
mkdir -p ./dags ./logs ./plugins ./config

# Create .env file
log "Creating .env file..."
echo -e "AIRFLOW_UID=$(id -u)" > .env

log "Airflow installation completed successfully!"