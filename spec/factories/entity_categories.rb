# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :entity_category do
    name 				"TestEntityCategory"
    description "The description of TestEntityCategory"
    active 			false
    parent_id 	0
  end
end
