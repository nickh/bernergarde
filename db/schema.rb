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

ActiveRecord::Schema.define(:version => 20110606004732) do

  create_table "certifications", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "club_memberships", :force => true do |t|
    t.integer "club_id"
    t.integer "member_id"
  end

  create_table "clubs", :force => true do |t|
    t.string "name"
  end

  create_table "completed_certifications", :force => true do |t|
    t.integer  "certification_id"
    t.integer  "dog_id"
    t.string   "certified_by"
    t.string   "tested"
    t.string   "identifier"
    t.string   "findings"
    t.date     "tested_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "completed_titles", :force => true do |t|
    t.integer "dog_id"
    t.integer "title_id"
    t.boolean "verified"
    t.date    "completed_at"
    t.string  "comments"
  end

  create_table "diagnoses", :force => true do |t|
    t.integer  "dog_id"
    t.string   "summary"
    t.string   "accuracy"
    t.string   "location"
    t.string   "metrical"
    t.date     "diagnosed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dogs", :force => true do |t|
    t.integer  "litter_id"
    t.integer  "owner_id"
    t.string   "registered_name"
    t.string   "call_name"
    t.string   "registration"
    t.string   "registry"
    t.string   "registration2"
    t.string   "registry2"
    t.string   "dna_registration"
    t.string   "data_source"
    t.boolean  "female"
    t.boolean  "neutered"
    t.boolean  "frozen_semen"
    t.date     "stud_book_date"
    t.date     "deceased_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "litters", :force => true do |t|
    t.integer "breeder_id"
    t.integer "sire_id"
    t.integer "dam_id"
    t.date    "whelp_date"
  end

  create_table "people", :force => true do |t|
    t.string   "second_name"
    t.string   "country"
    t.string   "address"
    t.string   "address2"
    t.string   "email"
    t.string   "phone"
    t.string   "fax"
    t.string   "web_site"
    t.string   "kennel_name"
    t.string   "bmdca_status"
    t.string   "data_source"
    t.boolean  "deceased"
    t.boolean  "master_household"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.boolean  "display_contact_info"
  end

  create_table "titles", :force => true do |t|
    t.string "code"
    t.string "description"
  end

end
