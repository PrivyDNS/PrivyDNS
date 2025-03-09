# Use an official Python runtime as a parent image
FROM python:3.12-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install dependencies from requirements.txt
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Run pytest to test the code when the container is run
CMD ["pytest", "--maxfail=1", "--disable-warnings", "-q"]
