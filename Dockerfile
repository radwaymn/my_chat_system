# Use a Ruby base image
FROM ruby:3.4.7-slim

# Set working directory
WORKDIR /app

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install packages needed to build gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential default-mysql-client default-libmysqlclient-dev git libyaml-dev pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install dependencies
RUN bundle install

# Copy the rest of the application code
COPY . .

# Prepare bash for entrypoint
RUN apt-get install -y bash 
COPY bin/docker-entrypoint /app/bin/docker-entrypoint
RUN chmod +x /app/bin/docker-entrypoint

# Entrypoint prepares the database.
ENTRYPOINT ["/app/bin/docker-entrypoint"]

# Expose the port Rails will run on
EXPOSE 3000

# Start the Rails server
CMD ["./bin/rails", "server"]