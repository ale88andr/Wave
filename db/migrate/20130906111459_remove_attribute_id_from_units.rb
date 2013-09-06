class RemoveAttributeIdFromUnits < ActiveRecord::Migration
  def change
  	remove_column :units, :attribute_id
  end
end
