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

ActiveRecord::Schema.define(:version => 20140604050633) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories_dishes", :force => true do |t|
    t.integer "category_id"
    t.integer "dish_id"
  end

  add_index "categories_dishes", ["category_id", "dish_id"], :name => "index_categories_dishes_on_category_id_and_dish_id"

  create_table "cuisines", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "dishes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "dishes_recipes", :id => false, :force => true do |t|
    t.integer "dish_id",   :null => false
    t.integer "recipe_id", :null => false
  end

  add_index "dishes_recipes", ["dish_id", "recipe_id"], :name => "index_dishes_recipes_on_dish_id_and_recipe_id"

  create_table "ingredients", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "main_ingredients", :force => true do |t|
    t.integer  "ingredient_id"
    t.integer  "recipe_id"
    t.boolean  "is_main_ingredient", :default => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  add_index "main_ingredients", ["ingredient_id", "recipe_id"], :name => "index_main_ingredients_on_ingredient_id_and_recipe_id"

  create_table "occassions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "occassions_recipes", :force => true do |t|
    t.integer  "occassion_id"
    t.integer  "recipe_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "occassions_recipes", ["occassion_id", "recipe_id"], :name => "index_occassions_recipes_on_occassion_id_and_recipe_id"

  create_table "recipes", :force => true do |t|
    t.string   "name"
    t.string   "information"
    t.text     "preparation_method"
    t.integer  "cooking_time"
    t.integer  "serves"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "recipeable_id"
    t.string   "recipeable_type"
    t.integer  "start_preparation_time"
    t.integer  "end_preparation_time"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
