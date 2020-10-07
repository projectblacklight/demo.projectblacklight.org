# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

require 'solr_wrapper/rake_task' unless Rails.env.production?
task(:default).clear
task default: [:ci]

desc "Execute the test build that runs on travis"
task ci: [:environment] do
  if Rails.env.test?
    require 'solr_wrapper'
    Rake::Task['db:migrate'].invoke

    SolrWrapper.wrap(port: '8983') do |solr|
      solr.with_collection(name: 'blacklight-core', dir: Rails.root.join('solr/conf')) do
        Rake::Task['blacklight:index:seed'].invoke
        Rake::Task['spec'].invoke
      end
    end
  end
end
