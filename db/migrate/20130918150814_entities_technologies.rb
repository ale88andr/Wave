class EntitiesTechnologies < ActiveRecord::Migration
  def change
  	create_table :entities_technologies, id: false do |t|
      t.references :entity
      t.references :technology
    end
    add_index :entities_technologies, :entity_id
    add_index :entities_technologies, :technology_id
  end
end
