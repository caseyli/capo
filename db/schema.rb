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

ActiveRecord::Schema.define(:version => 20120205070718) do

  create_table "hosted_open_mics_hosts", :id => false, :force => true do |t|
    t.integer "hosted_open_mic_id"
    t.integer "host_id"
  end

  create_table "open_mics", :force => true do |t|
    t.string   "name"
    t.string   "day_of_week"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.time     "start_time"
    t.time     "end_time"
    t.string   "street_1"
    t.string   "street_2"
    t.string   "city"
    t.string   "prov_state"
    t.string   "postal_zip"
    t.string   "country"
    t.string   "url"
    t.boolean  "published"
  end

  create_table "open_mics_users", :id => false, :force => true do |t|
    t.integer "open_mic_id"
    t.integer "user_id"
  end

  create_table "posts", :force => true do |t|
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "open_mic_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
