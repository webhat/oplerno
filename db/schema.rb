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

ActiveRecord::Schema.define(:version => 20140507155351) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "canvas_courses", :force => true do |t|
    t.text     "name"
    t.integer  "canvas_id"
    t.integer  "course_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "canvas_courses", ["name"], :name => "index_canvas_courses_on_name"

  create_table "canvas_users", :force => true do |t|
    t.integer  "user_id"
    t.text     "avatar_url"
    t.integer  "canvas_id"
    t.text     "locale"
    t.text     "username"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "canvas_users", ["user_id"], :name => "index_canvas_users_on_user_id"
  add_index "canvas_users", ["username"], :name => "index_canvas_users_on_username"

  create_table "carts", :force => true do |t|
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.float    "total_price"
    t.date     "purchased_at"
    t.integer  "user_id"
  end

  add_index "carts", ["user_id"], :name => "index_carts_on_user_id"

  create_table "carts_courses", :force => true do |t|
    t.integer "cart_id"
    t.integer "course_id"
  end

  add_index "carts_courses", ["cart_id"], :name => "index_carts_courses_on_cart_id"
  add_index "carts_courses", ["course_id", "cart_id"], :name => "index_carts_courses_on_course_id_and_cart_id", :unique => true
  add_index "carts_courses", ["course_id"], :name => "index_carts_courses_on_course_id"

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.string   "key"
    t.integer  "price"
    t.text     "description",         :limit => 255
    t.string   "teacher"
    t.string   "filename"
    t.string   "content_type"
    t.string   "binary_data"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.date     "start_date"
    t.string   "type"
    t.text     "syllabus"
    t.boolean  "hidden"
  end

  create_table "courses_skills", :force => true do |t|
    t.integer "skill_id"
    t.integer "course_id"
  end

  add_index "courses_skills", ["course_id", "skill_id"], :name => "index_courses_skills_on_course_id_and_skill_id", :unique => true
  add_index "courses_skills", ["course_id"], :name => "index_courses_skills_on_course_id"
  add_index "courses_skills", ["skill_id"], :name => "index_courses_skills_on_skill_id"

  create_table "courses_subjects", :force => true do |t|
    t.integer "subject_id"
    t.integer "course_id"
  end

  add_index "courses_subjects", ["course_id", "subject_id"], :name => "index_courses_subjects_on_course_id_and_subject_id", :unique => true
  add_index "courses_subjects", ["course_id"], :name => "index_courses_subjects_on_course_id"
  add_index "courses_subjects", ["subject_id"], :name => "index_courses_subjects_on_subject_id"

  create_table "courses_users", :force => true do |t|
    t.integer "user_id"
    t.integer "course_id"
  end

  add_index "courses_users", ["course_id"], :name => "index_courses_users_on_course_id"
  add_index "courses_users", ["user_id", "course_id"], :name => "index_courses_users_on_user_id_and_course_id", :unique => true
  add_index "courses_users", ["user_id"], :name => "index_courses_users_on_user_id"

  create_table "order_transactions", :force => true do |t|
    t.integer  "order_id"
    t.string   "action"
    t.integer  "amount"
    t.boolean  "success"
    t.string   "authorization"
    t.string   "message"
    t.binary   "params"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.binary   "params_key"
    t.binary   "params_iv"
    t.string   "txn_id"
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.text     "transactions"
    t.integer  "cart_id"
    t.string   "ip"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "orders", ["cart_id"], :name => "index_orders_on_cart_id"
  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"

  create_table "searches", :force => true do |t|
    t.text     "term"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "skills", :force => true do |t|
    t.string "skill"
  end

  create_table "students", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "subjects", :force => true do |t|
    t.string "subject"
  end

  add_index "subjects", ["subject"], :name => "index_subjects_on_subject", :unique => true

  create_table "teachers", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.binary   "title",                   :limit => 255
    t.binary   "first_name",              :limit => 255
    t.binary   "last_name",               :limit => 255
    t.string   "username"
    t.text     "description",             :limit => 255
    t.string   "hidden"
    t.string   "filename"
    t.string   "content_type"
    t.string   "binary_data"
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
    t.string   "email",                                  :default => "",    :null => false
    t.binary   "encrypted_password",      :limit => 255, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                          :default => 0,     :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                        :default => 0,     :null => false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authy_id"
    t.datetime "last_sign_in_with_authy"
    t.boolean  "authy_enabled",                          :default => false
    t.binary   "secret"
    t.binary   "secret_key"
    t.binary   "secret_iv"
    t.binary   "title_key"
    t.binary   "title_iv"
    t.binary   "first_name_key"
    t.binary   "first_name_iv"
    t.binary   "last_name_key"
    t.binary   "last_name_iv"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text     "links"
  end

  add_index "users", ["authy_id"], :name => "index_users_on_authy_id"
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
