# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_04_28_232700) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "budget_periods", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.decimal "balance", precision: 11, scale: 2, default: "0.0", null: false
    t.integer "month", null: false
    t.integer "year", null: false
    t.integer "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "total_income", precision: 11, scale: 2, default: "0.0", null: false
    t.decimal "total_expenses", precision: 11, scale: 2, default: "0.0", null: false
    t.integer "transaction_count", default: 0, null: false
    t.integer "income_count", default: 0, null: false
    t.integer "expense_count", default: 0, null: false
    t.index ["uid"], name: "index_budget_periods_on_uid", unique: true
    t.index ["user_id"], name: "index_budget_periods_on_user_id"
  end

  create_table "expense_categories", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.string "color", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "default", default: false, null: false
    t.index ["user_id"], name: "index_expense_categories_on_user_id"
  end

  create_table "expense_transactions", force: :cascade do |t|
    t.bigint "budget_period_id", null: false
    t.string "description"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "expense_category_id", null: false
    t.index ["budget_period_id"], name: "index_expense_transactions_on_budget_period_id"
    t.index ["expense_category_id"], name: "index_expense_transactions_on_expense_category_id"
  end

  create_table "income_transactions", force: :cascade do |t|
    t.bigint "budget_period_id", null: false
    t.string "description", null: false
    t.decimal "amount", precision: 11, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["budget_period_id"], name: "index_income_transactions_on_budget_period_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "budget_periods", "users"
  add_foreign_key "expense_categories", "users"
  add_foreign_key "expense_transactions", "budget_periods"
  add_foreign_key "expense_transactions", "expense_categories"
  add_foreign_key "income_transactions", "budget_periods"
end
