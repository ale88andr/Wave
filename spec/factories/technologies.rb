# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :technology do
    sequence(:name) { |n| "Technology #{n}"}
    description 		"Description technology"
    label 					"path/to/label"
  end
end
