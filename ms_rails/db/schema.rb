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

ActiveRecord::Schema.define(:version => 20091114205700) do

  create_table "celebrities", :force => true do |t|
    t.string "first_name"
    t.string "last_name"
    t.date   "dob"
    t.string "position"
  end

  create_table "celebrities_items", :id => false, :force => true do |t|
    t.integer "item_id"
    t.integer "celebrity_id"
    t.string  "position"
  end

  create_table "copies", :force => true do |t|
    t.integer "item_id"
    t.string  "copy_type"
    t.float   "sale_price"
    t.float   "wholesale_price"
    t.integer "section_id"
  end

  create_table "customers", :force => true do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "street_1"
    t.string "street_2"
    t.string "city"
    t.string "zip"
    t.string "email"
    t.string "phone"
  end

  create_table "employees", :force => true do |t|
    t.string  "first_name"
    t.string  "last_name"
    t.string  "password"
    t.boolean "enabled"
    t.string  "position"
  end

  create_table "items", :force => true do |t|
    t.string "title"
    t.date   "year"
    t.string "genre"
    t.string "item_type"
  end

  create_table "items_studios", :id => false, :force => true do |t|
    t.integer "item_id"
    t.integer "studio_id"
  end

  create_table "sales", :force => true do |t|
    t.integer "copy_id"
    t.string  "customer_id"
    t.date    "transaction_date"
    t.integer "employee_id"
    t.string  "transaction_type"
    t.float   "transaction_ammount"
    t.string  "coupon_note"
  end

  create_table "sections", :force => true do |t|
    t.string "name"
    t.string "location"
  end

  create_table "studios", :force => true do |t|
    t.string "name"
    t.string "category"
  end

end
