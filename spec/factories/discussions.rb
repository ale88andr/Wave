# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :discussion do
    user nil
    entity nil
    comment "MyText"
    positive "MyText"
    negative "MyText"
    answer 1
  end
end
