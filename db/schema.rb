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

ActiveRecord::Schema[7.1].define(version: 2025_07_08_020122) do
  create_table "notifications", charset: "utf8", force: :cascade do |t|
    t.string "message"
    t.bigint "user_id", null: false
    t.boolean "is_read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "options", charset: "utf8", force: :cascade do |t|
    t.string "content"
    t.bigint "poll_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["poll_id"], name: "index_options_on_poll_id"
  end

  create_table "poll_views", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "poll_id", null: false
    t.datetime "viewed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["poll_id"], name: "index_poll_views_on_poll_id"
    t.index ["user_id"], name: "index_poll_views_on_user_id"
  end

  create_table "polls", charset: "utf8", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.datetime "expires_at"
    t.boolean "allows_multiple", default: false
    t.boolean "anonymous", default: false
    t.bigint "user_id", null: false
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_polls_on_user_id"
  end

  create_table "users", charset: "utf8", force: :cascade do |t|
    t.string "role"
    t.string "user_name", null: false
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "option_id", null: false
    t.bigint "poll_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["option_id"], name: "index_votes_on_option_id"
    t.index ["poll_id"], name: "index_votes_on_poll_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "notifications", "users"
  add_foreign_key "options", "polls"
  add_foreign_key "poll_views", "polls"
  add_foreign_key "poll_views", "users"
  add_foreign_key "polls", "users"
  add_foreign_key "votes", "options"
  add_foreign_key "votes", "polls"
  add_foreign_key "votes", "users"
end
