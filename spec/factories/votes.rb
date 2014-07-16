# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vote do
    direction 1
    sequence(:user_id) { create(:user).id }
    association :votable, factory: :article
  end
end
