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

ActiveRecord::Schema.define(:version => 20110728041700) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "meta"
    t.integer  "parent_id"
    t.integer  "taxonomy_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "translation_id"
  end

  create_table "category_collections", :force => true do |t|
    t.integer  "category_id"
    t.integer  "collection_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "collection_users", :force => true do |t|
    t.integer  "collection_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "collections", :force => true do |t|
    t.string   "name"
    t.string   "status"
    t.string   "organization"
    t.string   "privacy"
    t.string   "meta"
    t.string   "url_about"
    t.text     "contact_info"
    t.text     "notes"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "country"
    t.text     "state"
    t.text     "city"
  end

  create_table "languages", :force => true do |t|
    t.string   "bibliographic_code", :limit => 3, :null => false
    t.string   "terminologic_code"
    t.string   "digit2_code"
    t.integer  "sort_group"
    t.string   "english_name",                    :null => false
    t.string   "french_name",                     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "post_title"
    t.text     "post_text"
    t.string   "post_author"
    t.string   "author_email"
    t.integer  "topic_id"
    t.integer  "collection_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "taxonomy_id"
  end

  create_table "relationships", :force => true do |t|
    t.integer  "category_id"
    t.integer  "synonym_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :force => true do |t|
    t.integer  "role_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "taxonomies", :force => true do |t|
    t.string   "name"
    t.string   "status"
    t.string   "privacy"
    t.string   "meta"
    t.string   "url_about"
    t.string   "url_category_html"
    t.string   "url_category_xml"
    t.integer  "language_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "internationalization_id"
  end

  create_table "taxonomy_users", :force => true do |t|
    t.integer  "ontology_id"
    t.integer  "user_id"
    t.integer  "language_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_users", :force => true do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "privacy"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", :force => true do |t|
    t.string   "topic_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",        :limit => 80
    t.string   "last_name",         :limit => 80
    t.string   "email",             :limit => 100
    t.string   "username",                                            :null => false
    t.boolean  "active",                           :default => false, :null => false
    t.string   "crypted_password",                                    :null => false
    t.string   "password_salt",                                       :null => false
    t.string   "persistence_token",                                   :null => false
    t.string   "perishable_token",                                    :null => false
    t.integer  "login_count",                      :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.integer  "validation_id"
  end

  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "validations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
