# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :valid_user, :class => User do
    name                    'user'
    password                'Pa$$w0rd'
    password_confirmation   'Pa$$w0rd'
    email                   'user@mail.com'
  end

  factory :invalid_user, parent: :valid_user do
    name nil
  end
end
