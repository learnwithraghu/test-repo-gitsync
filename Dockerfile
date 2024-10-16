# Use Python image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Install Flask
RUN pip install flask

# Copy the app script
COPY app.py .

# Expose the port
EXPOSE 5000

# Run the app
CMD ["python", "app.py"]
