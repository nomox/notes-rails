require 'resque'
require 'resque-scheduler'
require 'resque/scheduler/server'

Resque.redis = ENV.fetch('REDIS_URL') { 'redis://localhost:6379' }
Resque.schedule = YAML.load_file(Rails.root.join('config/resque_schedule.yml'))
