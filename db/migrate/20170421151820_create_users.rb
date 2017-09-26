class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "activation_digest"
    t.string   "reset_digest"
    t.string   "remember_digest"
    t.datetime "create_at"
    t.datetime "update_at"
    t.datetime "activated_at"
    t.boolean  "activated",         default: false
    t.datetime "reset_digest_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index([:email], unique: true)
    end
  end
end
