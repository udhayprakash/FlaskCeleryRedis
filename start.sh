#!/bin/bash

# Define the container name
CONTAINER_NAME="flask-redis-celery-app"

# Check if the container is already running
if docker ps | grep -q $CONTAINER_NAME; then
    echo "Stopping the container..."
    docker stop $CONTAINER_NAME
fi

# Check if the container exists (running or stopped)
if docker ps -a | grep -q $CONTAINER_NAME; then
    echo "Removing the container..."
    docker rm $CONTAINER_NAME
fi

# Build the Docker image
docker build -t flask-redis-celery .

# Run the Docker container
# docker run -d -p 5000:5000 -p 6379:6379 --name $CONTAINER_NAME flask-redis-celery
docker run -it -p 5000:5000 -p 6379:6379 --name $CONTAINER_NAME flask-redis-celery
