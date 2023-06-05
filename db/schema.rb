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

ActiveRecord::Schema[7.0].define(version: 2023_06_05_003718) do
  create_table "dislikes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "dislikeable_type", null: false
    t.integer "dislikeable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dislikeable_type", "dislikeable_id", "user_id"], name: "index_dislikes_on_dislikeable_and_user", unique: true
    t.index ["dislikeable_type", "dislikeable_id"], name: "index_dislikes_on_dislikeable"
    t.index ["user_id"], name: "index_dislikes_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "likeable_type", null: false
    t.integer "likeable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["likeable_type", "likeable_id", "user_id"], name: "index_likes_on_likeable_type_and_likeable_id_and_user_id", unique: true
    t.index ["likeable_type", "likeable_id"], name: "index_likes_on_likeable"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "whodunit_id", null: false
    t.string "notifiable_type", null: false
    t.integer "notifiable_id", null: false
    t.string "action", null: false
    t.datetime "read_at"
    t.datetime "notified_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notifiable_type", "notifiable_id"], name: "index_notifications_on_notifiable"
    t.index ["user_id"], name: "index_notifications_on_user_id"
    t.index ["whodunit_id"], name: "index_notifications_on_whodunit_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.integer "user_id"
    t.string "source"
    t.string "source_id"
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "likes_count", default: 0, null: false
    t.integer "dislikes_count", default: 0, null: false
    t.string "source_url"
    t.index ["source", "source_id", "user_id"], name: "index_source_source_id_and_user_id", unique: true
    t.index ["user_id"], name: "index_videos_on_user_id"
  end

  add_foreign_key "notifications", "users"
  add_foreign_key "notifications", "users", column: "whodunit_id"
end
