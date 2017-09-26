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

ActiveRecord::Schema.define(version: 20170528222807) do

  create_table "blogs", force: :cascade do |t|
    t.text     "body",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id_id"
    t.index ["user_id_id"], name: "index_blogs_on_user_id_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string   "pcomment_type"
    t.integer  "pcomment_id"
    t.integer  "number_nesting",             default: 0
    t.integer  "user_id",                                    null: false
    t.text     "body",           limit: 500
    t.boolean  "deleted",                    default: false
    t.integer  "parent_id"
    t.datetime "deleted_at"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.index ["parent_id"], name: "index_comments_on_parent_id"
    t.index ["pcomment_type", "pcomment_id"], name: "index_comments_on_pcomment_type_and_pcomment_id"
  end

  create_table "games", force: :cascade do |t|
    t.string   "name",                                  null: false
    t.integer  "level",                     default: 3
    t.string   "city",                                  null: false
    t.string   "street",                                null: false
    t.integer  "max_vacancies_for_players",             null: false
    t.integer  "user_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.datetime "time_event"
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                     limit: 30
    t.string   "email"
    t.string   "password_digest"
    t.string   "activation_digest"
    t.string   "reset_digest"
    t.string   "remember_digest"
    t.datetime "activated_at"
    t.boolean  "activated",                           default: false
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "image"
    t.datetime "reset_password_at"
    t.datetime "send_activation_token_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "vacancies", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_vacancies_on_game_id"
    t.index ["user_id", "game_id"], name: "index_vacancies_on_user_id_and_game_id", unique: true
    t.index ["user_id"], name: "index_vacancies_on_user_id"
  end

end
