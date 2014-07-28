# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vote do
    direction 1
    user
    association :votable, factory: :article
  end
end
