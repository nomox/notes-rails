# Use an official Ruby image as the base image
FROM ruby:2.7.8

# Set the working directory inside the container
WORKDIR /app

# Copy the Gemfile and Gemfile.lock to the container
COPY Gemfile Gemfile.lock ./

# Install dependencies using Bundler
RUN bundle install

# Copy the rest of the application code to the container
COPY . .

# Expose port 3000 (or the port your Rails app is configured to run on)
EXPOSE 3000

# Start the Rails server when the container starts
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]
