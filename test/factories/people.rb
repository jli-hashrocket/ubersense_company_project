FactoryGirl.define do
  factory :person do
    sequence(:email) { |n| "foo#{n}@example.com" }
    sequence(:name) { |n| "Foobario the #{n}" }
  end
end
