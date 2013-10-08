class Order < ActiveRecord::Base
  attr_accessible :cart_id, :entity_id, :quantity

  belongs_to :cart
  belongs_to :entity

  before_save :set_default_quantity

  DEFAULT_QUANTITY = 1

  def total_price
    entity.price * quantity
  end

  private

    def set_default_quantity
      self.quantity = DEFAULT_QUANTITY
    end

end