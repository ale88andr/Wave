class CreateManufacturers < ActiveRecord::Migration
  def change
    create_table :manufacturers do |t|
      t.string :name
      t.text :description
      t.string :url
      t.string :image
    end
    add_index :manufacturers, :name, unique: true
  end
end
