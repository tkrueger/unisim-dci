#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

UnisimDci::Application.load_tasks

namespace :spec do
  desc "Create rspec coverage"
  task :coverage do
    ENV['COVERAGE'] = 'true'
    Rake::Task["spec"].execute
  end
end