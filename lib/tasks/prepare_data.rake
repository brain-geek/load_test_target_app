#encoding: utf-8

task "prepare_data" => :environment do
  Rake::Task["db:drop"].invoke
  Rake::Task["db:create"].invoke
  Rake::Task["db:migrate"].invoke

  user = FactoryGirl.create :user, username: 'admin', email: 'admin@example.com', password: 'password', password_confirmation: 'password'

  user.roles << ::Refinery::Role[:refinery]
  user.roles << ::Refinery::Role[:superuser]

  user.save!

  root = FactoryGirl.create :page, path: '/', link_url: '/', title: 'Главная', deletable: false, 
    parts: [
      ::Refinery::PagePart.new(:body => Faker::HTMLIpsum.body, title: 'Body'),
      ::Refinery::PagePart.new(:body => Faker::HTMLIpsum.p, title: 'Side Body')
    ]
end