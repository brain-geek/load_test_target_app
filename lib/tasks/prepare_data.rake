#encoding: utf-8

root_pages = (ENV['ROOT_PAGES'] || 3).to_i
first_level_pages = (ENV['FIRST_LEVEL_PAGES'] || 10).to_i
second_level_pages = (ENV['SECOND_LEVEL_PAGES'] || 30).to_i

lag_level = (ENV['LAG_LEVEL'] || 0).to_i

task "prepare_data" => :environment do
  puts 'Recreating database'

  Rake::Task["db:drop"].invoke
  Rake::Task["db:create"].invoke
  Rake::Task["db:migrate"].invoke

  puts 'Creating settings'
  Refinery::Setting.set :lag_level, lag_level

  puts 'Creating admin and "/" page'

  FactoryGirl.create :refinery_admin
  root_page = FactoryGirl.create :root_page

  puts "Creating #{root_pages} root pages"

  root_pages.times do 
    FactoryGirl.create :page, :show_in_menu => true
  end

  puts "Creating #{first_level_pages} first level pages"

  first_level_pages.times do 
    FactoryGirl.create :page, :parent => (Refinery::Page.where(:depth => 0).first(:order => "RANDOM()"))
  end

  puts "Creating #{second_level_pages} second level pages"

  second_level_pages.times do 
    FactoryGirl.create :page, :parent => (Refinery::Page.where(:depth => 1).first(:order => "RANDOM()"))
  end

  puts 'Done.'
end