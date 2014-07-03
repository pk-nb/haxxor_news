# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    body 'Zee comment'
    user
    association :commentable, factory: :article
  end
end
