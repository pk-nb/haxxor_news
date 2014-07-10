# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vote do
    direction 1
    user_id factory: :user
    association :votable, factory: :article
  end
end
