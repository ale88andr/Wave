class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :entity_id
      t.integer :cart_id
      t.integer :quantity

      t.timestamps
    end
  end
end
