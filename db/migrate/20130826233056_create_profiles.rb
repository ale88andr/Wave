class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.boolean :show_email,      :null => false, :default => false
      t.date    :birthday
      t.string  :country
      t.integer :gender
      t.text    :about
      t.text    :signature
      t.string  :contacts_phone
      t.string  :contacts_skype
      t.string  :contacts_other
      t.string  :contacts_url
      t.string  :time_zone
      t.boolean :dispatch,        :null => false, :default => false
      t.string  :avatar

      t.references :user
    end
    add_index :profiles, :user_id
  end
end
