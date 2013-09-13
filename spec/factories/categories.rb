# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category do
    sequence(:name)   { |n| "TestEntityCategory #{n}" }
    description       "The description of TestEntityCategory"
    active            false
    parent_id         0
  end
end
