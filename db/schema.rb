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

ActiveRecord::Schema[7.0].define(version: 2023_08_11_181459) do
  create_table "abilities", force: :cascade do |t|
    t.string "name", null: false
    t.string "uses"
    t.string "qualifier"
    t.string "condition"
    t.text "effect", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "character_id"
    t.boolean "is_passive"
    t.index ["character_id"], name: "index_abilities_on_character_id"
  end

  create_table "characters", force: :cascade do |t|
    t.string "name", null: false
    t.integer "level", default: 1
    t.text "motivation"
    t.text "specialty"
    t.integer "will", default: 0
    t.integer "move", default: 0
    t.integer "fight", default: 0
    t.integer "sense", default: 0
    t.integer "seek", default: 0
    t.text "equipment"
    t.integer "plot_armor", default: 7
    t.integer "experience_points", default: 0
    t.integer "strength", default: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by_user_id"
    t.integer "in_use_by_user_id"
    t.integer "ability_count", default: 4
    t.index ["in_use_by_user_id"], name: "index_characters_on_in_use_by_user_id"
  end

  create_table "notes", force: :cascade do |t|
    t.integer "user_id"
    t.string "title"
    t.text "body"
    t.boolean "private"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "abilities", "characters"
  add_foreign_key "characters", "users", column: "in_use_by_user_id"
end
