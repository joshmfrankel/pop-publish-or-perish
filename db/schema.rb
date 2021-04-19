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

ActiveRecord::Schema.define(version: 2021_02_17_161815) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "academics", force: :cascade do |t|
    t.string "name", null: false
    t.string "title"
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.string "encrypted_password", limit: 128, null: false
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.index ["email"], name: "index_academics_on_email"
    t.index ["remember_token"], name: "index_academics_on_remember_token"
  end

  create_table "journal_methodologies", force: :cascade do |t|
    t.bigint "journal_id", null: false
    t.bigint "methodology_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["journal_id"], name: "index_journal_methodologies_on_journal_id"
    t.index ["methodology_id"], name: "index_journal_methodologies_on_methodology_id"
  end

  create_table "journals", force: :cascade do |t|
    t.string "title", null: false
    t.decimal "impact_factor", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "approved_at"
    t.bigint "approver_id"
    t.index ["approver_id"], name: "index_journals_on_approver_id"
  end

  create_table "methodologies", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "journal_methodologies", "journals"
  add_foreign_key "journal_methodologies", "methodologies"
  add_foreign_key "journals", "academics", column: "approver_id"
end
