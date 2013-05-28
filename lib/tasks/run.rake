task "run_app" => :environment do
  Rake::Task["unicorn:stop"].invoke

  Rake::Task["unicorn:stop"].invoke

  Rake::Task["db:drop"].invoke
  Rake::Task["db:create"].invoke
  Rake::Task["db:migrate"].invoke

  sleep 3

  puts ENV['RAILS_ENV']

  Rake::Task["prepare_data"].invoke

  sleep 3

  Rake::Task["unicorn:start"].invoke
end
