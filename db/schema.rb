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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160928100950) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "bags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "is_instant"
  end

  create_table "customers", force: :cascade do |t|
    t.string   "nombre"
    t.string   "telefono"
    t.string   "calle"
    t.string   "colonia"
    t.integer  "numero_interior"
    t.integer  "numero_exterior"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.text     "anotaciones"
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingredientes", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "measurement_unit_id"
    t.float    "stock"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "ingredientes", ["measurement_unit_id"], name: "index_ingredientes_on_measurement_unit_id"

  create_table "ingredients", force: :cascade do |t|
    t.string   "name"
    t.integer  "stock"
    t.integer  "measurement_unit_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "platillo_id"
  end

  add_index "ingredients", ["measurement_unit_id"], name: "index_ingredients_on_measurement_unit_id"
  add_index "ingredients", ["platillo_id"], name: "index_ingredients_on_platillo_id"

  create_table "measurement_units", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "table_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "status"
    t.boolean  "takeaway",    default: false
    t.integer  "customer_id"
    t.float    "payment"
  end

  add_index "orders", ["customer_id"], name: "index_orders_on_customer_id"
  add_index "orders", ["table_id"], name: "index_orders_on_table_id"

  create_table "platillo_ingredientes", force: :cascade do |t|
    t.integer  "platillo_id"
    t.integer  "ingredient_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "platillo_ingredientes", ["ingredient_id"], name: "index_platillo_ingredientes_on_ingredient_id"
  add_index "platillo_ingredientes", ["platillo_id"], name: "index_platillo_ingredientes_on_platillo_id"

  create_table "platillo_ingredients", force: :cascade do |t|
    t.integer  "platillo_id"
    t.integer  "ingredient_id"
    t.float    "cantidad"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "platillo_ingredients", ["ingredient_id"], name: "index_platillo_ingredients_on_ingredient_id"
  add_index "platillo_ingredients", ["platillo_id"], name: "index_platillo_ingredients_on_platillo_id"

  create_table "platillos", force: :cascade do |t|
    t.string   "name"
    t.float    "price"
    t.integer  "category_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "file_name"
    t.string   "map_file_name"
    t.string   "map_content_type"
    t.integer  "map_file_size"
    t.datetime "map_updated_at"
    t.integer  "group_id"
    t.boolean  "is_child"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
  end

  add_index "platillos", ["category_id"], name: "index_platillos_on_category_id"
  add_index "platillos", ["group_id"], name: "index_platillos_on_group_id"

  create_table "saucer_orders", force: :cascade do |t|
    t.integer  "platillo_id"
    t.integer  "order_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "notes"
    t.integer  "status"
    t.float    "price"
    t.integer  "quantity"
    t.boolean  "takeaway",    default: false
    t.integer  "bag_id"
    t.integer  "user_id"
  end

  add_index "saucer_orders", ["bag_id"], name: "index_saucer_orders_on_bag_id"
  add_index "saucer_orders", ["order_id"], name: "index_saucer_orders_on_order_id"
  add_index "saucer_orders", ["platillo_id"], name: "index_saucer_orders_on_platillo_id"
  add_index "saucer_orders", ["user_id"], name: "index_saucer_orders_on_user_id"

  create_table "tables", force: :cascade do |t|
    t.string   "description"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "tipo"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
