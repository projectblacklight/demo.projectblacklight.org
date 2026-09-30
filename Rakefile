# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

task(:default).clear
task default: [:ci]

def system_with_error_handling(*args)
  Open3.popen3(*args) do |_stdin, stdout, stderr, thread|
    puts stdout.read
    raise "Unable to run #{args.inspect}: #{stderr.read}" unless thread.value.success?
  end
end

def with_solr(&block)
  # We're being invoked by the app entrypoint script and solr is already up via docker compose
  if system('docker compose version')
    begin
      puts "Starting Solr"
      system_with_error_handling "docker compose up -d solr"
      yield
    ensure
      puts "Stopping Solr"
      system_with_error_handling "docker compose stop solr"
    end
  else
    warn "Docker Compose not available, skipping Solr setup"
  end
end

desc "Execute the test build that runs on Github Actions"
task ci: [:environment] do
  if Rails.env.test?
    with_solr do
      Rake::Task['blacklight:index:seed'].invoke
      Rake::Task['spec'].invoke
    end
  end
end
