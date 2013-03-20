# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110519133800) do

  create_table "administrators", :force => true do |t|
    t.string   "name"
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", :force => true do |t|
    t.string   "picture"
    t.string   "name"
    t.string   "author"
    t.text     "description"
    t.string   "isbn"
    t.integer  "price",             :precision => 10, :scale => 0
    t.integer  "books_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books_categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "free_books", :force => true do |t|
    t.string   "picture"
    t.string   "title"
    t.string   "book_url"
    t.string   "author"
    t.text     "description"
    t.integer  "books_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "line_items", :force => true do |t|
    t.integer  "book_id",                                   :null => false
    t.integer  "order_id",                                  :null => false
    t.integer  "quantity",                                  :null => false
    t.decimal  "total_price", :precision => 8, :scale => 2, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ozekimessageins", :force => true do |t|
    t.string "sender"
    t.string "receiver"
    t.string "msg"
    t.string "senttime"
    t.string "receivedtime"
  end

  create_table "ozekimessageouts", :force => true do |t|
    t.integer "order_id"
    t.string  "sender"
    t.string  "receiver"
    t.string  "msg"
    t.string  "senttime"
    t.string  "receivedtime"
    t.string  "status"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "transactions", :force => true do |t|
    t.integer  "order_id"
    t.string   "name"
    t.string   "pnumber"
    t.integer  "amount",     :precision => 10, :scale => 0
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "mpesa_no"
    t.string   "email"
    t.string   "address"
    t.string   "town"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
