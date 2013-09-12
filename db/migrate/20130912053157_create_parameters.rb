class CreateParameters < ActiveRecord::Migration
  def change
    create_table :parameters do |t|
      t.references 	:attribute
      t.references 	:entity
      t.string 			:value
    end
    add_index :parameters, :attribute_id
    add_index :parameters, :entity_id
  end
end
