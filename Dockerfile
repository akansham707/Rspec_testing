# Use the official Ruby 2.7 image as the base
FROM ruby:2.7.8

# Install dependencies for PostgreSQL client and other system libraries
RUN apt-get update -qq && \
    apt-get install -y postgresql-client build-essential libpq-dev && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /usr/src/app

# Install a specific version of Bundler
RUN gem install bundler:2.3.20

# Copy Gemfile and Gemfile.lock to avoid reinstalling gems unnecessarily
COPY Gemfile Gemfile.lock ./

# Install required gems
RUN bundle install --without development test

# Copy the rest of the application files
COPY . .

# Expose port 3000 to the outside world (for the Rails server)
EXPOSE 3000

# Set the default command to start the Rails server
CMD ["rails", "s", "-b", "0.0.0.0"]
