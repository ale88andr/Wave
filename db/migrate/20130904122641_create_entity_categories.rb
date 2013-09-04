class CreateEntityCategories < ActiveRecord::Migration
  def change
    create_table :entity_categories do |t|
      t.string :name
      t.text :description
      t.boolean :active,		default: true
      t.integer :parent_id,	null: false, default: 0
    end
    add_index :entity_categories, :name, :unique => true
  end
end