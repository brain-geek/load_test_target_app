#encoding: utf-8

task "prepare_data" => :environment do
  Rake::Task["db:drop"].invoke
  Rake::Task["db:create"].invoke
  Rake::Task["db:migrate"].invoke

  user = FactoryGirl.create :refinery_admin

  root_page = FactoryGirl.create :root_page

  3.times do 
    FactoryGirl.create :page, :show_in_menu => true
  end

  10.times do 
    FactoryGirl.create :page, :parent => (Refinery::Page.where(:depth => 0).first(:order => "RANDOM()"))
  end

  30.times do 
    FactoryGirl.create :page, :parent => (Refinery::Page.where(:depth => 1).first(:order => "RANDOM()"))
  end
end