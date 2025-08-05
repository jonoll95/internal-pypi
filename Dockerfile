# Use official Python base image
FROM python:3.11-slim

# Metadata
LABEL maintainer="jo.noll@schalke04.de"
LABEL description="Minimal internal PyPI server using pypiserver"

# Set environment variables
ENV PACKAGES_DIR=/packages

RUN apt-get update && apt-get install -y apache2-utils \
    && mkdir -p /etc/pypiserver \
    && htpasswd -cb /etc/pypiserver/.htpasswd test test \
    && pip install --no-cache-dir pypiserver passlib

# Copy the htpasswd file
COPY .htpasswd /etc/pypiserver/.htpasswd


# Expose the default port
EXPOSE 8080

# Start the server on container startup
CMD ["pypi-server", "run", "-a", "update", "-P", "/etc/pypiserver/.htpasswd", "/packages"]

