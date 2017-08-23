# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

if Rake::Task.task_defined?("default")
  Rake::Task["default"].clear
end

namespace :parallel do
  desc "Pre commit task"
  task(:dev, [:count, :options] => [:single_preparations]) do |_, args|
    ParallelTests::Tasks.run_in_parallel("rake preparations RAILS_ENV=#{ParallelTests::Tasks.rails_env}", args)
    Rake::Task['parallel:spec'].invoke(args.count,"^spec/models|^spec/controllers|^spec/helpers|^spec/libs|^spec/routing|^spec/jobs|^spec/requests", args.options)
  end
end

task :single_preparations => %w(tmp:clear log:clear assets:clean)
task :preparations => %w(db:drop db:test:prepare)
task :unit_functional => %w(spec:models spec:controllers spec:helpers spec:libs spec:routing spec:jobs)
task :default => %w(single_preparations preparations unit_functional)
