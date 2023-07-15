# Use a Python base image
FROM python:3.9

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file to the container
COPY requirements.txt .

# Install dependencies
RUN pip install -U pip
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Flask app, Redis configuration, and Celery worker file to the container
COPY app.py .
COPY redis.conf .
COPY celery_worker.py .

# Install supervisor
RUN apt-get update && apt-get install -y supervisor

# Configure supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose ports for Flask and Redis
EXPOSE 5000
EXPOSE 6379

# Start supervisord to run both Flask and Celery
CMD ["supervisord", "-n", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
