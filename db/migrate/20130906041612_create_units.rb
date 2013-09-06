class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :param
      t.references :attributes
    end
    add_index :units, :attributes_id
  end
end
