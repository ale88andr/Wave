class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :name
      t.string :abbreviation
      t.float :ratio
    end
  end
end
