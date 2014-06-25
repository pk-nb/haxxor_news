# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    sequence(:url) { |n| "http://article#{n}.com" }
    sequence(:title) { |n| "Article #{n}" }
  end
end
