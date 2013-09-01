# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_role, class: Role do
    name  "admin"
    id    1
  end

  factory :manager_role, class: Role do
    name  "manager"
    id    2
  end

  factory :user_role, class: Role do
    name  "user"
    id    3
  end
end