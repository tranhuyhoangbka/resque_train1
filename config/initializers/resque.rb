require 'resque/failure/multiple'
require 'resque/failure/redis'
require 'resque/failure/airbrake'

rails_root = ENV['RAILS_ROOT'] || File.dirname(__FILE__) + '/../..'
rails_env = ENV['RAILS_ENV'] || 'development'
resque_config = YAML.load_file "#{rails_root}/config/resque.yml"
Resque.redis = resque_config[rails_env]
Resque.redis.namespace = "resque:test"

Resque::Failure::Multiple.classes = [Resque::Failure::Redis, Resque::Failure::Airbrake]
Resque::Failure.backend = Resque::Failure::Multiple
