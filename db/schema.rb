# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_12_194554) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customer_subscriptions", force: :cascade do |t|
    t.string "customer_subscription_id"
    t.bigint "customer_id", null: false
    t.bigint "subscription_id", null: false
    t.boolean "is_active", default: true
    t.datetime "renews_on"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "payment_method_id"
    t.index ["customer_id"], name: "index_customer_subscriptions_on_customer_id"
    t.index ["customer_subscription_id"], name: "index_customer_subscriptions_on_customer_subscription_id", unique: true
    t.index ["payment_method_id"], name: "index_customer_subscriptions_on_payment_method_id"
    t.index ["subscription_id"], name: "index_customer_subscriptions_on_subscription_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "customer_id"
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_customers_on_customer_id", unique: true
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "payment_method_id"
    t.bigint "customer_id", null: false
    t.datetime "payment_expires_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "payment_zip_code"
    t.string "payment_token"
    t.index ["customer_id"], name: "index_payment_methods_on_customer_id"
    t.index ["payment_method_id"], name: "index_payment_methods_on_payment_method_id", unique: true
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "subscription_id"
    t.string "subscription_name"
    t.integer "subscription_price"
    t.integer "subscription_term"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subscription_id"], name: "index_subscriptions_on_subscription_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "user_id"
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_users_on_user_id", unique: true
  end

  add_foreign_key "customer_subscriptions", "customers"
  add_foreign_key "customer_subscriptions", "payment_methods"
  add_foreign_key "customer_subscriptions", "subscriptions"
  add_foreign_key "payment_methods", "customers"
end
