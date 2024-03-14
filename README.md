# Simple backend service for Note-taking application

## Steps to get the application up and running.

##### Prerequisites

Make sure following tools installed on the system.

- Ruby 2.7
- Rails 6.1.7
- MySQL 8.3

##### Clone the repository

```bash
git clone git@github.com:nomox/notes-rails.git
```

##### Run Bundle

```bash
bundle install
```

##### Setup the database

```bash
rake db:setup
```

##### Start the Rails server

```bash
bundle exec rails s
```

##### Run background workers

```bash
QUEUE=* VERBOSE=1 rake resque:work
```

```bash
rake resque:scheduler
```

## Testing

##### Run RSpec test

```bash
bundle exec rspec
```
