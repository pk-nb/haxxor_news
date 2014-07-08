# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user_#{n}" }
    sequence(:email) { |n| "user_#{n}@email.com" }
    password 'testtesttest'
    password_confirmation 'testtesttest'
    password_reset_token nil
    password_reset_sent_at nil
  end
end
