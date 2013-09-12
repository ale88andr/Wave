# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130912053157) do

  create_table "attributes", :force => true do |t|
    t.string  "name"
    t.integer "unit_id"
  end

  add_index "attributes", ["unit_id"], :name => "index_attributes_on_unit_id"

  create_table "attributes_categories", :id => false, :force => true do |t|
    t.integer "attribute_id"
    t.integer "category_id"
  end

  add_index "attributes_categories", ["attribute_id"], :name => "index_attributes_categories_on_attribute_id"
  add_index "attributes_categories", ["category_id"], :name => "index_attributes_categories_on_category_id"

  create_table "categories", :force => true do |t|
    t.string  "name"
    t.text    "description"
    t.boolean "active",      :default => true
    t.integer "parent_id",   :default => 0,    :null => false
  end

  add_index "categories", ["name"], :name => "index_entity_categories_on_name", :unique => true

  create_table "entities", :force => true do |t|
    t.string   "name"
    t.float    "price"
    t.float    "price_in_currency"
    t.boolean  "bind_price",              :default => false, :null => false
    t.integer  "currency_id"
    t.text     "description"
    t.integer  "discount_id"
    t.date     "price_start_date"
    t.date     "price_end_date"
    t.string   "image"
    t.boolean  "published",               :default => true,  :null => false
    t.string   "advise"
    t.float    "additional_shiping_cost"
    t.integer  "views"
    t.integer  "rate"
    t.text     "characteristics"
    t.integer  "manufacturer_id"
    t.integer  "category_id"
    t.integer  "availability"
    t.integer  "guarantee"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  add_index "entities", ["category_id"], :name => "index_entities_on_category_id"
  add_index "entities", ["currency_id"], :name => "index_entities_on_currency_id"
  add_index "entities", ["discount_id"], :name => "index_entities_on_discount_id"
  add_index "entities", ["manufacturer_id"], :name => "index_entities_on_manufacturer_id"
  add_index "entities", ["name"], :name => "index_entities_on_name", :unique => true

  create_table "manufacturers", :force => true do |t|
    t.string "name"
    t.text   "description"
    t.string "url"
    t.string "image"
  end

  add_index "manufacturers", ["name"], :name => "index_manufacturers_on_name", :unique => true

  create_table "parameters", :force => true do |t|
    t.integer "attribute_id"
    t.integer "entity_id"
    t.string  "value"
  end

  add_index "parameters", ["attribute_id"], :name => "index_parameters_on_attribute_id"
  add_index "parameters", ["entity_id"], :name => "index_parameters_on_entity_id"

  create_table "profiles", :force => true do |t|
    t.boolean "show_email",     :default => false, :null => false
    t.date    "birthday"
    t.string  "country"
    t.integer "gender"
    t.text    "about"
    t.text    "signature"
    t.string  "contacts_phone"
    t.string  "contacts_skype"
    t.string  "contacts_other"
    t.string  "contacts_url"
    t.string  "time_zone"
    t.boolean "dispatch",       :default => false, :null => false
    t.string  "avatar"
    t.integer "user_id"
  end

  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id"

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

  create_table "units", :force => true do |t|
    t.string "param"
  end

  create_table "users", :force => true do |t|
    t.string   "name",                   :default => "", :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
