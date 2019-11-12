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

ActiveRecord::Schema.define(version: 20190629235305) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

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

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "bags", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "status"
    t.integer  "sucursal_id"
  end

  add_index "bags", ["sucursal_id"], name: "index_bags_on_sucursal_id", using: :btree

  create_table "cancellations", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "justificacion"
    t.string   "platillo"
    t.integer  "quantity"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "sucursal_id"
  end

  add_index "cancellations", ["sucursal_id"], name: "index_cancellations_on_sucursal_id", using: :btree
  add_index "cancellations", ["user_id"], name: "index_cancellations_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "is_instant"
  end

  create_table "cedis", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "configs", force: :cascade do |t|
    t.integer  "iva"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "errors", force: :cascade do |t|
    t.integer  "clave"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expenses", force: :cascade do |t|
    t.integer  "category"
    t.decimal  "amount"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "description"
    t.integer  "quantity"
    t.integer  "sucursal_id"
    t.integer  "ingrediente_id"
    t.integer  "user_id"
  end

  add_index "expenses", ["ingrediente_id"], name: "index_expenses_on_ingrediente_id", using: :btree
  add_index "expenses", ["sucursal_id"], name: "index_expenses_on_sucursal_id", using: :btree
  add_index "expenses", ["user_id"], name: "index_expenses_on_user_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingredientes", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "measurement_unit_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "ingredientes", ["measurement_unit_id"], name: "index_ingredientes_on_measurement_unit_id", using: :btree

  create_table "ingredients", force: :cascade do |t|
    t.string   "name"
    t.float    "stock"
    t.integer  "measurement_unit_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "platillo_id"
    t.integer  "ingrediente_id"
  end

  add_index "ingredients", ["ingrediente_id"], name: "index_ingredients_on_ingrediente_id", using: :btree
  add_index "ingredients", ["measurement_unit_id"], name: "index_ingredients_on_measurement_unit_id", using: :btree
  add_index "ingredients", ["platillo_id"], name: "index_ingredients_on_platillo_id", using: :btree

  create_table "inputs", force: :cascade do |t|
    t.integer  "resource_id"
    t.float    "cantidad"
    t.float    "precio"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "inputs", ["resource_id"], name: "index_inputs_on_resource_id", using: :btree

  create_table "inventarios", force: :cascade do |t|
    t.integer  "sucursal_id"
    t.integer  "ingrediente_id"
    t.float    "existencia"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.float    "minimo"
  end

  add_index "inventarios", ["ingrediente_id"], name: "index_inventarios_on_ingrediente_id", using: :btree
  add_index "inventarios", ["sucursal_id"], name: "index_inventarios_on_sucursal_id", using: :btree

  create_table "measurement_units", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movements", force: :cascade do |t|
    t.integer  "tipo"
    t.decimal  "cantidad",    precision: 15, scale: 2
    t.integer  "user_id"
    t.string   "descripcion"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "movements", ["user_id"], name: "index_movements_on_user_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "table_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "status"
    t.boolean  "takeaway",        default: false
    t.integer  "customer_id"
    t.float    "payment"
    t.string   "nombre"
    t.string   "telefono"
    t.string   "calle"
    t.string   "numero_exterior"
    t.string   "numero_interior"
    t.string   "colonia"
    t.text     "notas"
    t.integer  "sucursal_id"
    t.integer  "cajero_id"
  end

  add_index "orders", ["customer_id"], name: "index_orders_on_customer_id", using: :btree
  add_index "orders", ["sucursal_id"], name: "index_orders_on_sucursal_id", using: :btree
  add_index "orders", ["table_id"], name: "index_orders_on_table_id", using: :btree

  create_table "passwords", force: :cascade do |t|
    t.string   "pass"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "platillo_ingredientes", force: :cascade do |t|
    t.integer  "platillo_id"
    t.integer  "ingredient_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "platillo_ingredientes", ["ingredient_id"], name: "index_platillo_ingredientes_on_ingredient_id", using: :btree
  add_index "platillo_ingredientes", ["platillo_id"], name: "index_platillo_ingredientes_on_platillo_id", using: :btree

  create_table "platillo_ingredients", force: :cascade do |t|
    t.integer  "platillo_id"
    t.integer  "ingredient_id"
    t.float    "cantidad"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "platillo_ingredients", ["ingredient_id"], name: "index_platillo_ingredients_on_ingredient_id", using: :btree
  add_index "platillo_ingredients", ["platillo_id"], name: "index_platillo_ingredients_on_platillo_id", using: :btree

  create_table "platillos", force: :cascade do |t|
    t.string   "name"
    t.float    "price"
    t.integer  "category_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
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
    t.text     "descripcion"
    t.boolean  "actualizado",        default: false
  end

  add_index "platillos", ["category_id"], name: "index_platillos_on_category_id", using: :btree
  add_index "platillos", ["group_id"], name: "index_platillos_on_group_id", using: :btree

  create_table "requets", force: :cascade do |t|
    t.integer  "sucursal_id"
    t.integer  "status"
    t.string   "anotaciones"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "requets", ["sucursal_id"], name: "index_requets_on_sucursal_id", using: :btree

  create_table "requets_lines", force: :cascade do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "ingrediente_id"
    t.integer  "requet_id"
    t.float    "cantidad"
    t.string   "anotaciones"
  end

  add_index "requets_lines", ["ingrediente_id"], name: "index_requets_lines_on_ingrediente_id", using: :btree
  add_index "requets_lines", ["requet_id"], name: "index_requets_lines_on_requet_id", using: :btree

  create_table "resources", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "measurement_unit_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "resources", ["measurement_unit_id"], name: "index_resources_on_measurement_unit_id", using: :btree

  create_table "resurces", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "saucer_orders", force: :cascade do |t|
    t.integer  "platillo_id"
    t.integer  "order_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "notes"
    t.float    "price"
    t.integer  "quantity"
    t.boolean  "takeaway",    default: false
    t.integer  "bag_id"
    t.integer  "user_id"
    t.float    "discount",    default: 0.0
    t.integer  "iva",         default: 0
    t.integer  "sucursal_id"
  end

  add_index "saucer_orders", ["bag_id"], name: "index_saucer_orders_on_bag_id", using: :btree
  add_index "saucer_orders", ["order_id"], name: "index_saucer_orders_on_order_id", using: :btree
  add_index "saucer_orders", ["platillo_id"], name: "index_saucer_orders_on_platillo_id", using: :btree
  add_index "saucer_orders", ["sucursal_id"], name: "index_saucer_orders_on_sucursal_id", using: :btree
  add_index "saucer_orders", ["user_id"], name: "index_saucer_orders_on_user_id", using: :btree

  create_table "sucursals", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tables", force: :cascade do |t|
    t.string   "description"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "take_away"
    t.integer  "sucursal_id"
  end

  add_index "tables", ["sucursal_id"], name: "index_tables_on_sucursal_id", using: :btree

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
    t.integer  "sucursal_id"
    t.integer  "cedi_id"
  end

  add_index "users", ["cedi_id"], name: "index_users_on_cedi_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["sucursal_id"], name: "index_users_on_sucursal_id", using: :btree

  add_foreign_key "bags", "sucursals"
  add_foreign_key "cancellations", "sucursals"
  add_foreign_key "cancellations", "users"
  add_foreign_key "expenses", "ingredientes"
  add_foreign_key "expenses", "sucursals"
  add_foreign_key "expenses", "users"
  add_foreign_key "ingredientes", "measurement_units"
  add_foreign_key "ingredients", "ingredientes"
  add_foreign_key "ingredients", "measurement_units"
  add_foreign_key "ingredients", "platillos"
  add_foreign_key "inputs", "resources"
  add_foreign_key "inventarios", "ingredientes"
  add_foreign_key "inventarios", "sucursals"
  add_foreign_key "movements", "users"
  add_foreign_key "orders", "customers"
  add_foreign_key "orders", "sucursals"
  add_foreign_key "orders", "tables"
  add_foreign_key "platillo_ingredientes", "ingredients"
  add_foreign_key "platillo_ingredientes", "platillos"
  add_foreign_key "platillo_ingredients", "ingredients"
  add_foreign_key "platillo_ingredients", "platillos"
  add_foreign_key "platillos", "categories"
  add_foreign_key "platillos", "groups"
  add_foreign_key "requets", "sucursals"
  add_foreign_key "requets_lines", "ingredientes"
  add_foreign_key "requets_lines", "requets"
  add_foreign_key "resources", "measurement_units"
  add_foreign_key "saucer_orders", "bags"
  add_foreign_key "saucer_orders", "orders"
  add_foreign_key "saucer_orders", "platillos"
  add_foreign_key "saucer_orders", "sucursals"
  add_foreign_key "saucer_orders", "users"
  add_foreign_key "tables", "sucursals"
  add_foreign_key "users", "cedis"
  add_foreign_key "users", "sucursals"
end
