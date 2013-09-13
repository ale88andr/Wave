# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attribute do
    sequence(:name) { |i| "Attribute #{i}" }
    unit_id 				1
  end
end
