# Base image: small official Python image
FROM python:3.12-slim

LABEL maintainer="Zhebegenov Ersultan <IT2-2309, 37138>"

# Default values (can be overridden with `docker run -e ...`)
ENV PYTHONUNBUFFERED=1 \
    APP_PORT=8000 \
    STUDENT_NAME=Ersultan \
    STUDENT_SURNAME=Zhebegenov \
    STUDENT_GROUP=IT2-2309 \
    STUDENT_ID=37138

# Working directory inside the image
WORKDIR /app

# Copy the application code and config into the image
COPY app/ /app/
COPY config/app.conf /app/config/app.conf

# Create a non-root user and give it the app files
RUN useradd --create-home appuser && chown -R appuser:appuser /app
USER appuser

# The application listens on this port
EXPOSE 8000

# Command executed when the container starts
CMD ["python", "app.py"]
