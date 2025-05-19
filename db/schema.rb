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

ActiveRecord::Schema[8.0].define(version: 2025_04_14_014443) do
  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expense_payers", force: :cascade do |t|
    t.integer "expense_id", null: false
    t.integer "user_id", null: false
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expense_id"], name: "index_expense_payers_on_expense_id"
    t.index ["user_id"], name: "index_expense_payers_on_user_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.string "description"
    t.decimal "amount"
    t.integer "trip_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
    t.string "currency"
    t.decimal "total_amount"
    t.integer "payer_id"
    t.index ["trip_id"], name: "index_expenses_on_trip_id"
  end

  create_table "expenses_participants", id: false, force: :cascade do |t|
    t.integer "expense_id", null: false
    t.integer "participant_id", null: false
    t.index ["expense_id"], name: "index_expenses_participants_on_expense_id"
    t.index ["participant_id"], name: "index_expenses_participants_on_participant_id"
  end

  create_table "participants", force: :cascade do |t|
    t.string "name"
    t.integer "user_id", null: false
    t.integer "trip_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_id"], name: "index_participants_on_trip_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "amount"
    t.string "description"
    t.date "date"
    t.string "currency"
    t.integer "trip_id", null: false
    t.integer "user_id", null: false
    t.integer "recipient_id", null: false
    t.integer "participant_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["participant_id"], name: "index_payments_on_participant_id"
    t.index ["recipient_id"], name: "index_payments_on_recipient_id"
    t.index ["trip_id"], name: "index_payments_on_trip_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_trips_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "expense_payers", "expenses"
  add_foreign_key "expense_payers", "users"
  add_foreign_key "expenses", "trips", on_delete: :cascade
  add_foreign_key "expenses_participants", "expenses", on_delete: :cascade
  add_foreign_key "expenses_participants", "participants", on_delete: :cascade
  add_foreign_key "participants", "trips", on_delete: :cascade
  add_foreign_key "participants", "users"
  add_foreign_key "payments", "participants", on_delete: :cascade
  add_foreign_key "payments", "trips", on_delete: :cascade
  add_foreign_key "payments", "users"
  add_foreign_key "payments", "users", column: "recipient_id"
  add_foreign_key "trips", "users"
end
