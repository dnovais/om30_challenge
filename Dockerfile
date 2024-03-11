# Use the official Ruby image as the base image
FROM ruby:3.3.0-slim as base

# Set the working directory inside the container
WORKDIR /app

# Install essential Linux packages
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    postgresql-client \
    git \
    curl \
    libvips \
    imagemagick

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile* /app/

# Install Ruby gems, skipping production group
RUN bundle config --global frozen 1 && \
    bundle install --without production

# Copy the main application
COPY . /app/

# Set the entrypoint
ENTRYPOINT ["bundle", "exec"]

# Start the Rails server by default
CMD ["rails", "server", "-b", "0.0.0.0"]
