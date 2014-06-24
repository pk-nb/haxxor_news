FactoryGirl.define do
  factory :session do
    sequence(:login) { |n| "user_#{n}" }
    password 'testtesttest'
  end
end
