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

ActiveRecord::Schema.define(:version => 20130624211748) do

  create_table "application_details", :force => true do |t|
    t.text     "the_text"
    t.string   "purpose"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "class_categories", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.integer  "position"
    t.boolean  "visible",    :default => true
    t.boolean  "external",   :default => false
    t.text     "foot_text"
    t.text     "head_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "class_dates", :force => true do |t|
    t.datetime "the_date"
    t.string   "note"
    t.boolean  "cancelled",        :default => false
    t.integer  "capacity"
    t.integer  "library_class_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "instructors"
  end

  create_table "class_sub_categories", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.integer  "position"
    t.boolean  "visible",           :default => true
    t.integer  "class_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "library_classes", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "location"
    t.integer  "position"
    t.integer  "class_category_id"
    t.integer  "class_sub_category_id"
    t.string   "alt_registration_text"
    t.boolean  "visible",               :default => true
    t.boolean  "registration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "registrations", :force => true do |t|
    t.integer  "class_date_id"
    t.integer  "user_id"
    t.boolean  "attended",      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "response_emails", :force => true do |t|
    t.string   "reply_to"
    t.string   "subject"
    t.text     "body"
    t.string   "purpose"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suggestions", :force => true do |t|
    t.string   "fullname"
    t.string   "username"
    t.string   "email"
    t.text     "suggestion"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "fullname"
    t.string   "username"
    t.string   "email"
    t.string   "phone"
    t.string   "program"
    t.string   "school"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "mobile_phone"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "session_id"
    t.string   "persistence_token"
    t.integer  "login_count"
    t.string   "last_request_at"
    t.string   "current_login_at"
    t.string   "last_login_at"
    t.string   "current_login_ip"
    t.text     "user_attributes"
    t.datetime "refreshed_at"
    t.string   "wherefrom"
  end

end
