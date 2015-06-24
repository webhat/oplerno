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

ActiveRecord::Schema.define(:version => 20150614213303) do

  create_table "accelerator_applications", :force => true do |t|
    t.string   "description"
    t.string   "email"
    t.integer  "team_id"
    t.integer  "mentor_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "accelerator_applications", ["mentor_id"], :name => "index_accelerator_applications_on_mentor_id"
  add_index "accelerator_applications", ["team_id"], :name => "index_accelerator_applications_on_team_id"

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
    t.datetime "deleted_at"
  end

  add_index "admin_users", ["deleted_at"], :name => "index_admin_users_on_deleted_at"
  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "advisors_companies", :force => true do |t|
    t.integer "angel_id"
    t.integer "company_id"
  end

  add_index "advisors_companies", ["angel_id"], :name => "index_advisors_companies_on_angel_id"
  add_index "advisors_companies", ["company_id", "angel_id"], :name => "index_advisors_companies_on_company_id_and_angel_id", :unique => true
  add_index "advisors_companies", ["company_id"], :name => "index_advisors_companies_on_company_id"

  create_table "analytics", :force => true do |t|
    t.string   "remote"
    t.string   "request"
    t.datetime "time"
    t.string   "status"
    t.string   "bytes"
    t.string   "referer"
    t.string   "user_agent"
    t.string   "method"
    t.string   "path"
    t.string   "protocol"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "analytics", ["path"], :name => "index_analytics_on_path"
  add_index "analytics", ["remote", "path", "time"], :name => "index_analytics_on_remote_and_path_and_time", :unique => true
  add_index "analytics", ["time"], :name => "index_analytics_on_time"

  create_table "angels", :force => true do |t|
    t.integer  "mentor_id"
    t.string   "angelslug"
    t.string   "twitterslug"
    t.string   "adviser_to"
    t.string   "investor_in"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "angels", ["mentor_id"], :name => "index_angels_on_mentor_id"

  create_table "canvas_courses", :force => true do |t|
    t.text     "name"
    t.integer  "canvas_id"
    t.integer  "course_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "syllabus"
  end

  add_index "canvas_courses", ["canvas_id"], :name => "index_canvas_courses_on_canvas_id", :unique => true
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

  create_table "certificates", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "teacher_id"
    t.string   "montage_file_name"
    t.string   "montage_content_type"
    t.integer  "montage_file_size"
    t.datetime "montage_updated_at"
    t.string   "slug"
  end

  add_index "certificates", ["slug"], :name => "index_certificates_on_slug"

  create_table "certificates_courses", :force => true do |t|
    t.integer "course_id"
    t.integer "certificate_id"
  end

  add_index "certificates_courses", ["certificate_id"], :name => "index_certificates_courses_on_certificate_id"
  add_index "certificates_courses", ["course_id"], :name => "index_certificates_courses_on_course_id"

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "company_url"
    t.string   "logo_url"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "companies", ["name"], :name => "index_companies_on_name", :unique => true

  create_table "companies_investors", :force => true do |t|
    t.integer "angel_id"
    t.integer "company_id"
  end

  add_index "companies_investors", ["angel_id"], :name => "index_companies_investors_on_angel_id"
  add_index "companies_investors", ["company_id", "angel_id"], :name => "index_companies_investors_on_company_id_and_angel_id", :unique => true
  add_index "companies_investors", ["company_id"], :name => "index_companies_investors_on_company_id"

  create_table "course_rankings", :force => true do |t|
    t.integer  "course_id"
    t.integer  "ranking"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "course_rankings", ["course_id"], :name => "index_course_rankings_on_course_id", :unique => true

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.string   "key"
    t.integer  "price"
    t.text     "description",         :limit => 255
    t.string   "teacher"
    t.string   "filename"
    t.string   "content_type"
    t.string   "binary_data"
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.date     "start_date"
    t.string   "type"
    t.text     "syllabus"
    t.boolean  "hidden"
    t.integer  "min",                                :default => 2
    t.integer  "max",                                :default => 25
    t.string   "slug"
    t.datetime "deleted_at"
  end

  add_index "courses", ["deleted_at"], :name => "index_courses_on_deleted_at"
  add_index "courses", ["slug"], :name => "index_courses_on_slug"

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

  create_table "courses_teachers", :force => true do |t|
    t.integer "course_id"
    t.integer "teacher_id"
  end

  add_index "courses_teachers", ["course_id"], :name => "index_courses_teachers_on_course_id"
  add_index "courses_teachers", ["teacher_id", "course_id"], :name => "index_courses_teachers_on_teacher_id_and_course_id", :unique => true
  add_index "courses_teachers", ["teacher_id"], :name => "index_courses_teachers_on_teacher_id"

  create_table "courses_users", :force => true do |t|
    t.integer "user_id"
    t.integer "course_id"
  end

  add_index "courses_users", ["course_id"], :name => "index_courses_users_on_course_id"
  add_index "courses_users", ["user_id", "course_id"], :name => "index_courses_users_on_user_id_and_course_id", :unique => true
  add_index "courses_users", ["user_id"], :name => "index_courses_users_on_user_id"

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "invite_credits", :force => true do |t|
    t.integer  "user_id"
    t.integer  "amount"
    t.boolean  "used"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "by_id"
  end

  add_index "invite_credits", ["user_id"], :name => "index_invite_credits_on_user_id"

  create_table "invites", :force => true do |t|
    t.integer  "user_id"
    t.string   "code"
    t.boolean  "active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "invites", ["user_id"], :name => "index_invites_on_user_id", :unique => true

  create_table "mentors", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "mentors_tags", :force => true do |t|
    t.integer "mentor_id"
    t.integer "tag_id"
  end

  add_index "mentors_tags", ["mentor_id"], :name => "index_mentors_tags_on_mentor_id"
  add_index "mentors_tags", ["tag_id", "mentor_id"], :name => "index_mentors_tags_on_tag_id_and_mentor_id", :unique => true
  add_index "mentors_tags", ["tag_id"], :name => "index_mentors_tags_on_tag_id"

  create_table "mentors_teams", :id => false, :force => true do |t|
    t.integer "team_id"
    t.integer "mentor_id"
  end

  add_index "mentors_teams", ["mentor_id"], :name => "index_mentors_teams_on_mentor_id"
  add_index "mentors_teams", ["team_id"], :name => "index_mentors_teams_on_team_id"

  create_table "order_transactions", :force => true do |t|
    t.integer  "order_id"
    t.string   "action"
    t.integer  "amount"
    t.boolean  "success"
    t.string   "authorization"
    t.string   "message"
    t.binary   "params"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.binary   "params_key"
    t.binary   "params_iv"
    t.string   "txn_id"
    t.binary   "params_completed"
    t.binary   "params_completed_key"
    t.binary   "params_completed_iv"
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

  create_table "podio_teachers", :force => true do |t|
    t.string   "field_68472121"
    t.string   "field_68472122"
    t.string   "field_68472123"
    t.string   "field_68472124"
    t.string   "field_68472125"
    t.string   "field_68472126"
    t.string   "field_68472127"
    t.string   "field_68472128"
    t.string   "field_68472129"
    t.string   "field_68472130"
    t.string   "field_68472131"
    t.string   "field_68472132"
    t.integer  "teacher_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "searches", :force => true do |t|
    t.text     "term"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "settings", :force => true do |t|
    t.string   "key"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "deleted_at"
  end

  add_index "settings", ["deleted_at"], :name => "index_settings_on_deleted_at"

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

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "slug"
  end

  add_index "tags", ["slug"], :name => "index_tags_on_slug"

  create_table "tags_teams", :force => true do |t|
    t.integer  "team_id"
    t.integer  "tag_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tags_teams", ["tag_id", "team_id"], :name => "index_tags_teams_on_tag_id_and_team_id", :unique => true
  add_index "tags_teams", ["tag_id"], :name => "index_tags_teams_on_tag_id"
  add_index "tags_teams", ["team_id"], :name => "index_tags_teams_on_team_id"

  create_table "teacher_rankings", :force => true do |t|
    t.integer  "teacher_id"
    t.integer  "ranking"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "teacher_rankings", ["teacher_id"], :name => "index_teacher_rankings_on_teacher_id", :unique => true

  create_table "teachers", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.text     "description", :limit => 255
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "slug"
  end

  add_index "teams", ["slug"], :name => "index_teams_on_slug"

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
    t.datetime "deleted_at"
    t.string   "privateemail"
    t.string   "slug"
  end

  add_index "users", ["authy_id"], :name => "index_users_on_authy_id"
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["deleted_at"], :name => "index_users_on_deleted_at"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["privateemail"], :name => "index_users_on_privateemail", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["slug"], :name => "index_users_on_slug"
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
