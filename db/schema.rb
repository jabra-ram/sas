# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_08_24_062644) do

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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "age_criteria", force: :cascade do |t|
    t.date "date_of_birth_after", null: false
    t.date "date_of_birth_before", null: false
    t.integer "age", null: false
    t.date "date_as_on", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "class_category_id"
    t.index ["class_category_id"], name: "index_age_criteria_on_class_category_id"
  end

  create_table "class_categories", force: :cascade do |t|
    t.integer "classname", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "class_sections", id: false, force: :cascade do |t|
    t.bigint "class_category_id", null: false
    t.bigint "section_id", null: false
  end

  create_table "fee_structures", force: :cascade do |t|
    t.integer "admission_fees", null: false
    t.integer "annual_admission_fees", null: false
    t.integer "caution_money", null: false
    t.integer "quarterly_tuition_fees", null: false
    t.integer "id_card_fees", null: false
    t.integer "total", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "class_category_id"
    t.index ["class_category_id"], name: "index_fee_structures_on_class_category_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.string "email", null: false
    t.string "token", null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "recipient_id", null: false
    t.integer "sender_id", null: false
    t.string "message", null: false
    t.boolean "read_status", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer "mode_of_payment", null: false
    t.integer "amount", null: false
    t.integer "status", null: false
    t.text "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "student_id"
    t.index ["student_id"], name: "index_payments_on_student_id"
  end

  create_table "sections", force: :cascade do |t|
    t.string "section", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.date "date_of_birth", null: false
    t.integer "age", null: false
    t.integer "academic_year", null: false
    t.string "father_name", null: false
    t.string "mother_name", null: false
    t.text "address", null: false
    t.bigint "contact_number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "class_category_id"
    t.bigint "section_id"
    t.index ["class_category_id"], name: "index_students_on_class_category_id"
    t.index ["section_id"], name: "index_students_on_section_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "age_criteria", "class_categories"
  add_foreign_key "fee_structures", "class_categories"
  add_foreign_key "payments", "students"
  add_foreign_key "students", "class_categories"
  add_foreign_key "students", "sections"
end
