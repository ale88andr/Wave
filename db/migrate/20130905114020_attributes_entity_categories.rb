class AttributesEntityCategories < ActiveRecord::Migration
  def change
  	create_table :attributes_entity_categories, id: false do |t|
  		t.integer :attribute_id
  		t.integer :entity_category_id
  	end
  	add_index :attributes_entity_categories, :attribute_id
  	add_index :attributes_entity_categories, :entity_category_id
  end
end
