# Use a base image with Python
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any necessary dependencies (none for this simple example)
# RUN pip install -r requirements.txt

# Define an environment variable
ENV NAME World

# Run a simple Python script when the container launches
CMD ["python", "app.py"]
