require 'resque/tasks'
require 'resque/scheduler/tasks'
require 'resque/pool/tasks'

namespace :resque do
  task :setup => :environment do
    require 'resque'
  end

  task :setup_schedule => :setup do
    require 'resque-scheduler'

    # If you want to be able to dynamically change the schedule,
    # uncomment this line.  A dynamic schedule can be updated via the
    # Resque::Scheduler.set_schedule (and remove_schedule) methods.
    # When dynamic is set to true, the scheduler process looks for
    # schedule changes and applies them on the fly.
    # Note: This feature is only available in >=2.0.0.
    # Resque::Scheduler.dynamic = true

    # The schedule doesn't need to be stored in a YAML, it just needs to
    # be a hash.  YAML is usually the easiest.
    Resque.schedule = YAML.load_file("#{Rails.root}/config/schedule.yml")
  end

  task :scheduler => :setup_schedule
end

task 'resque:pool:setup' do
  Resque::Pool.after_prefork do |job|
    Resque.redis.client.reconnect
  end
end

task "resque:pool:reload" do
  puts "reload the config file, reload logfiles, restart all workers"
  Process.kill :HUP,
    File.read(Rails.root.join("tmp", "pids", "resque-pool.pid")).to_i
end
