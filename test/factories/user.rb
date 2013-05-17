# This is a temporary hack to get around some hackery with Devise when
# using the authentication macros in request specs that are defined in
# refinerycms-testing. If you remove this line ensure that tests pass
# in an extension that is testing against this Factory via the
# authentication macros in refinerycms-testing.
# 10-11-2011 - Jamie Winsor - jamie@enmasse.com
require Refinery.roots(:'refinery/authentication').join("app/models/refinery/role.rb")

FactoryGirl.define do
  factory :user, :class => Refinery::User do
    sequence(:username) { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@refinerycms.com" }
    password  "password"
    password_confirmation "password"
  end

  factory :refinery_admin, :parent => :user do
    username 'admin'
    email 'admin@example.com' 

    after(:create) do |user, evaluator|
      user.roles << ::Refinery::Role[:refinery]
      user.roles << ::Refinery::Role[:superuser]
    end
  end
end
