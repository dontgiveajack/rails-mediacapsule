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

ActiveRecord::Schema.define(version: 2018_11_22_112919) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admin_tenants", force: :cascade do |t|
    t.string "company_name"
    t.string "subdomain"
    t.string "domain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "owner_id"
    t.string "predefined_metadata_fields", array: true
    t.string "customized_metadata_fields", array: true
    t.index ["domain"], name: "index_admin_tenants_on_domain", unique: true
    t.index ["owner_id"], name: "index_admin_tenants_on_owner_id"
    t.index ["subdomain"], name: "index_admin_tenants_on_subdomain", unique: true
  end

  create_table "tenant_folders", force: :cascade do |t|
    t.string "name"
    t.string "ancestry"
    t.bigint "tenant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "creator_id"
    t.bigint "folder_size", default: 0
    t.integer "ancestry_depth", default: 0
    t.boolean "is_favourite", default: false
    t.index ["ancestry"], name: "index_tenant_folders_on_ancestry"
    t.index ["creator_id"], name: "index_tenant_folders_on_creator_id"
    t.index ["tenant_id"], name: "index_tenant_folders_on_tenant_id"
  end

  create_table "tenant_media_items", force: :cascade do |t|
    t.bigint "folder_id"
    t.bigint "tenant_id"
    t.bigint "uploader_id"
    t.boolean "archived"
    t.boolean "online"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "predefined_metadata_fields"
    t.jsonb "customized_metadata_fields"
    t.boolean "is_favourite", default: false
    t.index ["folder_id"], name: "index_tenant_media_items_on_folder_id"
    t.index ["tenant_id"], name: "index_tenant_media_items_on_tenant_id"
    t.index ["uploader_id"], name: "index_tenant_media_items_on_uploader_id"
  end

  create_table "tenant_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.bigint "tenant_id"
    t.index ["confirmation_token"], name: "index_tenant_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_tenant_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_tenant_users_on_reset_password_token", unique: true
    t.index ["tenant_id"], name: "index_tenant_users_on_tenant_id"
    t.index ["unlock_token"], name: "index_tenant_users_on_unlock_token", unique: true
  end

end
