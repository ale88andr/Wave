# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order, :class => 'Orders' do
    entity_id 1
    cart_id 1
    quantity 1
  end
end
