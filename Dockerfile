# Use a base image with git, openssl, and docker-compose
FROM ruby:3.1-alpine

# Install required dependencies
RUN apk add --no-cache \
    git \
    openssl \
    docker-cli \
    bash \
    && gem install bundler

# Set the working directory
WORKDIR /app

# Clone the repository
RUN git clone --depth 1 https://github.com/getlago/lago.git .

# Set up the environment configuration (generate a private key)
RUN echo "LAGO_RSA_PRIVATE_KEY=\"$(openssl genrsa 2048 | base64)\"" >> .env

# Install Ruby dependencies
RUN bundle install

# Expose ports if necessary (depending on your application)
EXPOSE 3000

# Set the entrypoint to start the application (simulating docker-compose up)
CMD ["docker-compose", "up", "-d", "api"]
