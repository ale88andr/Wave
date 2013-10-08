class Cart < ActiveRecord::Base
  attr_accessible :user_id

  has_many :orders, dependent: :destroy
  belongs_to :users

  def total_price
    orders.to_a.sum { |order| order.total_price }
  end

  def add_product entity_id
    current_order = orders.find_by_entity_id(entity_id)
    if current_order
      current_order.update_attributes(quantity: current_order.quantity += 1)
    else
      current_order = orders.build(entity_id: entity_id)
    end
    current_order
  end

end
