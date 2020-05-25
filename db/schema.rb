# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_25_024339) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
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

  create_table "head_hunters", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", default: "Jesse Smith", null: false
    t.string "social_name"
    t.index ["email"], name: "index_head_hunters_on_email", unique: true
    t.index ["name"], name: "index_head_hunters_on_name"
    t.index ["reset_password_token"], name: "index_head_hunters_on_reset_password_token", unique: true
    t.index ["social_name"], name: "index_head_hunters_on_social_name"
    t.index ["unlock_token"], name: "index_head_hunters_on_unlock_token", unique: true
  end

  create_table "job_application_interviews", force: :cascade do |t|
    t.integer "head_hunter_id", null: false
    t.integer "job_application_id", null: false
    t.string "address"
    t.datetime "date"
    t.boolean "public_feedback", default: false
    t.text "feedback"
    t.boolean "occurred"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["head_hunter_id"], name: "index_job_application_interviews_on_head_hunter_id"
    t.index ["job_application_id"], name: "index_job_application_interviews_on_job_application_id"
  end

  create_table "job_application_offers", force: :cascade do |t|
    t.integer "job_application_id", null: false
    t.date "start_date", null: false
    t.integer "salary", null: false
    t.text "responsabilities", null: false
    t.text "benefits", null: false
    t.text "expectations"
    t.text "bonus"
    t.text "feedback"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "head_hunter_id", null: false
    t.index ["head_hunter_id"], name: "index_job_application_offers_on_head_hunter_id"
    t.index ["job_application_id"], name: "index_job_application_offers_on_job_application_id"
  end

  create_table "job_applications", force: :cascade do |t|
    t.integer "job_id", null: false
    t.integer "job_seeker_id", null: false
    t.text "cover_letter"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "standout", default: false
    t.text "rejection_feedback"
    t.index ["job_id"], name: "index_job_applications_on_job_id"
    t.index ["job_seeker_id"], name: "index_job_applications_on_job_seeker_id"
  end

  create_table "job_seeker_profile_comments", force: :cascade do |t|
    t.integer "job_seeker_profile_id", null: false
    t.integer "head_hunter_id", null: false
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["head_hunter_id"], name: "index_job_seeker_profile_comments_on_head_hunter_id"
    t.index ["job_seeker_profile_id"], name: "index_job_seeker_profile_comments_on_job_seeker_profile_id"
  end

  create_table "job_seeker_profile_favorites", force: :cascade do |t|
    t.integer "job_seeker_profile_id", null: false
    t.integer "head_hunter_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["head_hunter_id"], name: "index_job_seeker_profile_favorites_on_head_hunter_id"
    t.index ["job_seeker_profile_id"], name: "index_job_seeker_profile_favorites_on_job_seeker_profile_id"
  end

  create_table "job_seeker_profiles", force: :cascade do |t|
    t.date "date_of_birth"
    t.string "high_school"
    t.string "college"
    t.string "degrees"
    t.string "courses"
    t.string "interests"
    t.text "bio"
    t.string "work_experience"
    t.integer "job_seeker_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["job_seeker_id"], name: "index_job_seeker_profiles_on_job_seeker_id"
  end

  create_table "job_seekers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", default: "Jesse Smith", null: false
    t.string "social_name"
    t.index ["email"], name: "index_job_seekers_on_email", unique: true
    t.index ["name"], name: "index_job_seekers_on_name"
    t.index ["reset_password_token"], name: "index_job_seekers_on_reset_password_token", unique: true
    t.index ["social_name"], name: "index_job_seekers_on_social_name"
    t.index ["unlock_token"], name: "index_job_seekers_on_unlock_token", unique: true
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "skills"
    t.integer "salary_floor"
    t.integer "salary_roof"
    t.string "position"
    t.string "location"
    t.boolean "retired", default: false
    t.date "expires_on"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "head_hunter_id"
    t.index ["head_hunter_id"], name: "index_jobs_on_head_hunter_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "job_application_interviews", "head_hunters"
  add_foreign_key "job_application_interviews", "job_applications"
  add_foreign_key "job_application_offers", "head_hunters"
  add_foreign_key "job_application_offers", "job_applications"
  add_foreign_key "job_applications", "job_seekers"
  add_foreign_key "job_applications", "jobs"
  add_foreign_key "job_seeker_profile_comments", "head_hunters"
  add_foreign_key "job_seeker_profile_comments", "job_seeker_profiles"
  add_foreign_key "job_seeker_profile_favorites", "head_hunters"
  add_foreign_key "job_seeker_profile_favorites", "job_seeker_profiles"
  add_foreign_key "job_seeker_profiles", "job_seekers"
  add_foreign_key "jobs", "head_hunters"
end
