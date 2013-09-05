class CreateAttributes < ActiveRecord::Migration
  def change
    create_table :attributes do |t|
      t.string :name
      t.references :unit
    end
    add_index :attributes, :unit_id
  end
end