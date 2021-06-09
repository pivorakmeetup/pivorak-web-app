# frozen_string_literal: true

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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_210_611_211_002) do
  create_table 'shop_item_images', force: :cascade do |t|
    t.string 'image'
    t.integer 'item_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['item_id'], name: 'index_shop_item_images_on_item_id'
  end

  create_table 'shop_items', force: :cascade do |t|
    t.string 'name', null: false
    t.text 'description'
    t.decimal 'price', null: false
    t.integer 'available_qty', default: 0, null: false
    t.boolean 'published', default: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'shop_order_items', force: :cascade do |t|
    t.integer 'quantity'
    t.decimal 'price', null: false
    t.integer 'item_id'
    t.integer 'order_id'
    t.index ['item_id'], name: 'index_shop_order_items_on_item_id'
    t.index ['order_id'], name: 'index_shop_order_items_on_order_id'
  end

  create_table 'shop_orders', force: :cascade do |t|
    t.integer 'status', default: 0
    t.text 'shipment_address'
  end
end
