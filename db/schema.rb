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

ActiveRecord::Schema.define(:version => 20120722082255) do

  create_table "categories", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cities", :force => true do |t|
    t.integer  "country_id",               :null => false
    t.integer  "region_id",                :null => false
    t.string   "name",       :limit => 45, :null => false
    t.float    "latitude",                 :null => false
    t.float    "longitude",                :null => false
    t.string   "timezone",   :limit => 10, :null => false
    t.integer  "dma_id"
    t.string   "county",     :limit => 25
    t.string   "code",       :limit => 4
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "cities", ["name"], :name => "index_cities_on_name"

  create_table "countries", :force => true do |t|
    t.string   "name",                 :limit => 50, :null => false
    t.string   "fips104",              :limit => 2,  :null => false
    t.string   "iso2",                 :limit => 2,  :null => false
    t.string   "iso3",                 :limit => 3,  :null => false
    t.string   "ison",                 :limit => 4,  :null => false
    t.string   "internet",             :limit => 2,  :null => false
    t.string   "capital",              :limit => 25
    t.string   "map_reference",        :limit => 50
    t.string   "nationality_singular", :limit => 35
    t.string   "nationaiity_plural",   :limit => 35
    t.string   "currency",             :limit => 30
    t.string   "currency_code",        :limit => 3
    t.integer  "population"
    t.string   "title",                :limit => 50
    t.string   "comment"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "post_images", :force => true do |t|
    t.integer  "post_id"
    t.string   "image"
    t.boolean  "main_image", :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "status"
    t.string   "title"
    t.integer  "category_id"
    t.integer  "city_id"
    t.text     "description"
    t.text     "description_2"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "regions", :force => true do |t|
    t.integer  "country_id",               :null => false
    t.string   "name",       :limit => 45, :null => false
    t.string   "code",       :limit => 8,  :null => false
    t.string   "adm1code",   :limit => 4,  :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "fullname"
    t.string   "address"
    t.string   "phone"
    t.string   "profile"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "website"
    t.string   "avatar"
    t.string   "cover"
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
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
