# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username 'pknb'
    email 'pknb.fake@email.com'
    password 'testtesttest'
    password_confirmation 'testtesttest'
  end
end
