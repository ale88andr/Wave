# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :entity do
    sequence(:name)             { |n| "New Entity #{n}" }
    price                       1.5
    price_in_currency           1.5
    bind_price                  true
    description                 "MyText"
    price_start_date            "2013-09-11"
    price_end_date              "2013-09-11"
    image                       "MyString"
    published                   true
    advise                      "MyString"
    additional_shiping_cost     1.5
    views                       1
    rate                        1
    characteristics             "MyText"
    association :category,      factory: :category
    association :manufacturer,  factory: :manufacturer
    availability                1
    guarantee                   1
  end
end
