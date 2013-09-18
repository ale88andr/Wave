class CreateTechnologies < ActiveRecord::Migration
  def change
    create_table :technologies do |t|
      t.string :name
      t.text :description
      t.string :label
    end
    add_index :technologies, :name, :unique => true
  end
end
