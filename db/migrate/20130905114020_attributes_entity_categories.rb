class AttributesEntityCategories < ActiveRecord::Migration
  def change
  	create_table :attributes_entity_categories, id: false do |t|
  		t.references :attributes
  		t.references :entity_categories
  	end
  	add_index :attributes_entity_categories, :attributes_id
  	add_index :attributes_entity_categories, :entity_categories_id
  end
end
