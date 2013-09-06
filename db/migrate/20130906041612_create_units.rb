class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :param
    end
  end
end
