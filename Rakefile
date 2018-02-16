# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

require 'solr_wrapper/rake_task' unless Rails.env.production?

desc 'Run Continuous Integration test'
task :ci do
  puts "Starting solr"
  SolrWrapper.wrap(port: '8983') do |solr|
    solr.with_collection(name: 'blacklight-core',
                         verbose: true,
                         managed: true,
                         dir: File.join(__dir__, 'solr', 'conf')) do
      Rake::Task['test'].invoke
    end
  end
end

task default: :ci
