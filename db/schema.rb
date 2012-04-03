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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120403065246) do

  create_table "articles", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "body"
    t.boolean  "published"
    t.integer  "status"
    t.string   "tags"
    t.integer  "author"
    t.integer  "moderator"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "attachments", :force => true do |t|
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.string   "content"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "category"
  end

  create_table "businesses", :force => true do |t|
    t.string   "regno"
    t.integer  "biztype"
    t.integer  "industrypri"
    t.integer  "industrysec"
    t.string   "country"
    t.string   "address"
    t.integer  "founded"
    t.string   "shareholding"
    t.string   "mission"
    t.string   "founders"
    t.integer  "staffno"
    t.string   "keystaff"
    t.string   "investors"
    t.string   "advisors"
    t.text     "uvp"
    t.text     "revenuemodel"
    t.text     "target"
    t.string   "competitors"
    t.string   "nutshell"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "name"
    t.string   "type"
    t.boolean  "approved"
  end

  create_table "comments", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "parent_post"
    t.integer  "parent_comment"
    t.boolean  "toplevel"
    t.integer  "user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "contacts", :force => true do |t|
    t.string   "website"
    t.string   "blog"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "linkedin"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "contactable_id"
    t.string   "contactable_type"
  end

  create_table "entities", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.string   "roles"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "approved"
    t.integer  "approver"
  end

  create_table "feedbacks", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "body"
    t.boolean  "published"
    t.integer  "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "people", :force => true do |t|
    t.date     "birthdate"
    t.string   "designation"
    t.string   "company"
    t.string   "skills"
    t.text     "background"
    t.text     "portfolio"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "name"
    t.string   "type"
    t.boolean  "approved"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "roles"
    t.boolean  "active"
    t.string   "linkedinid"
    t.boolean  "banned"
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
