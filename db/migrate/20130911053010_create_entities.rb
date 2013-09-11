class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.string      :name
      t.float       :price
      t.float       :price_in_currency
      t.boolean     :bind_price,               :null => false, :default => false
      t.references  :currency
      t.text        :description
      t.references  :discount
      t.date        :price_start_date
      t.date        :price_end_date
      t.string      :image
      t.boolean     :published,                :null => false, :default => true
      t.string      :advise
      t.float       :additional_shiping_cost
      t.integer     :views
      t.integer     :rate
      t.text        :characteristics
      t.references  :manufacturer
      t.references  :category
      t.integer     :availability
      t.integer     :guarantee

      t.timestamps
    end
    add_index :entities, :name,           :unique => true
    add_index :entities, :currency_id
    add_index :entities, :discount_id
    add_index :entities, :manufacturer_id
    add_index :entities, :category_id
  end
end
