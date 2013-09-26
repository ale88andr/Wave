# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :currency do
    name "MyString"
    abbreviation "MyString"
    ratio 1.5
  end
end
