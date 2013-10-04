class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.references :user
      t.references :entity
      t.text :comment
      t.text :positive
      t.text :negative
      t.integer :answer

      t.timestamps
    end
    add_index :discussions, :user_id
    add_index :discussions, :entity_id
  end
end
