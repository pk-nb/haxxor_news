# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| username "user_#{n}" }
    sequence(:email) { |n| "user_#{n}@email.com" }
    password 'testtesttest'
    password_confirmation 'testtesttest'
  end
end
