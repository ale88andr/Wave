# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :valid_user, :class => User do
    sequence(:name)         {|i| "user #{i}"}
    password                'Pa$$w0rd'
    password_confirmation   'Pa$$w0rd'
    sequence(:email)        {|i| "user#{i}@mail.com"}
  end

  factory :invalid_user, parent: :valid_user do
    name nil
  end

  factory :admin_user, parent: :valid_user do
    roles { [FactoryGirl.create(:admin_role)] }
  end
end
