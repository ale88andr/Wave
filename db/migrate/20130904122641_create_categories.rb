class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string  :name
      t.text    :description
      t.boolean :active,		default: true
      t.integer :parent_id,	null: false, default: 0
    end
    add_index :categories, :name, :unique => true
  end
end