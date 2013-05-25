#encoding: utf-8
FactoryGirl.define do
  factory :page, :class => Refinery::Page do
    title { Faker::Lorem.words(2).join(' ').capitalize }
    show_in_menu false
    parts { [
      ::Refinery::PagePart.new(:body => Faker::HTMLIpsum.body_content, title: 'Body'),
      ::Refinery::PagePart.new(:body => Faker::HTMLIpsum.sidebar_content, title: 'Side Body')
    ] }

    factory :root_page do
      link_url '/'
      title 'Главная'
      deletable false
      show_in_menu true
    end
  end
end