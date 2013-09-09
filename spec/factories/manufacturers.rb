# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :manufacturer do
    sequence(:name)   { |i| "Manufacturer #{i}" }
    description       "Text description"
    url               "www.example.com"
    image             "path/to/image"
  end
end
