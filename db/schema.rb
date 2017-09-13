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

ActiveRecord::Schema.define(version: 20170913005306) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "application_for_events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "event_id"
    t.boolean "accepted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "info"
    t.uuid "user_id"
    t.boolean "volunteered_before", default: false, null: false
    t.boolean "been_before", default: false, null: false
    t.text "friends_or_referrals"
    t.boolean "terms_accepted"
    t.integer "rating", default: 0
    t.boolean "invitation_accepted"
    t.datetime "deleted_at"
    t.boolean "denied"
    t.index ["been_before"], name: "index_application_for_events_on_been_before"
    t.index ["deleted_at"], name: "index_application_for_events_on_deleted_at"
    t.index ["event_id"], name: "index_application_for_events_on_event_id"
    t.index ["user_id"], name: "index_application_for_events_on_user_id"
    t.index ["volunteered_before"], name: "index_application_for_events_on_volunteered_before"
  end

  create_table "application_preferred_jobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "job_id"
    t.uuid "application_for_event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_for_event_id"], name: "index_application_preferred_jobs_on_application_for_event_id"
    t.index ["job_id"], name: "index_application_preferred_jobs_on_job_id"
  end

  create_table "charges", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "event_id"
    t.uuid "user_id"
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "AUD", null: false
    t.string "description"
    t.string "stripe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_charges_on_event_id"
    t.index ["user_id"], name: "index_charges_on_user_id"
  end

  create_table "emergency_contacts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.string "name"
    t.string "phone_number"
    t.string "relationship"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_emergency_contacts_on_user_id"
  end

  create_table "event_accepted_volunteers", id: false, force: :cascade do |t|
    t.uuid "event_id"
    t.uuid "user_id"
    t.index ["event_id"], name: "index_event_accepted_volunteers_on_event_id"
    t.index ["user_id"], name: "index_event_accepted_volunteers_on_user_id"
  end

  create_table "event_applied_volunteers", id: false, force: :cascade do |t|
    t.uuid "event_id"
    t.uuid "user_id"
    t.index ["event_id"], name: "index_event_applied_volunteers_on_event_id"
    t.index ["user_id"], name: "index_event_applied_volunteers_on_user_id"
  end

  create_table "event_days", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "event_id"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["event_id"], name: "index_event_days_on_event_id"
    t.index ["slug"], name: "index_event_days_on_slug"
  end

  create_table "event_days_jobs", id: false, force: :cascade do |t|
    t.uuid "event_day_id"
    t.uuid "job_id"
    t.index ["event_day_id"], name: "index_event_days_jobs_on_event_day_id"
    t.index ["job_id"], name: "index_event_days_jobs_on_job_id"
  end

  create_table "events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.float "event_length"
    t.integer "ticket_price_cents"
    t.uuid "client_owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "slug"
    t.datetime "application_closing_date"
    t.string "initial_charge_description"
    t.integer "initial_charge_cents"
    t.datetime "deleted_at"
    t.index ["client_owner_id"], name: "index_events_on_client_owner_id"
    t.index ["deleted_at"], name: "index_events_on_deleted_at"
    t.index ["slug"], name: "index_events_on_slug"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "job_departments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.uuid "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "workers_per_rotation", default: 0
    t.integer "hours_per_rotation", default: 0
    t.integer "rotations_required_per_day", default: 0
    t.string "slug"
    t.index ["event_id"], name: "index_jobs_on_event_id"
    t.index ["slug"], name: "index_jobs_on_slug"
  end

  create_table "roles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "resource_id"
    t.string "resource_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "rotations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "shift_manager_id"
    t.uuid "day_id"
    t.uuid "job_id"
    t.integer "length", default: 1
    t.datetime "start_time"
    t.integer "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day_id"], name: "index_rotations_on_day_id"
    t.index ["job_id"], name: "index_rotations_on_job_id"
    t.index ["shift_manager_id"], name: "index_rotations_on_shift_manager_id"
  end

  create_table "shifts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "rotation_id"
    t.uuid "volunteer_id"
    t.integer "length", default: 1
    t.integer "start_time"
    t.integer "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rotation_id"], name: "index_shifts_on_rotation_id"
    t.index ["volunteer_id"], name: "index_shifts_on_volunteer_id"
  end

  create_table "skill_requirements", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "job_id"
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_skill_requirements_on_job_id"
  end

  create_table "skills", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "user_id"
    t.string "proof_document_file_name"
    t.string "proof_document_content_type"
    t.integer "proof_document_file_size"
    t.datetime "proof_document_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_skills_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "full_name"
    t.date "birthday"
    t.string "mobile_number"
    t.string "slug"
    t.integer "shifts_made", default: 0
    t.integer "shifts_missed", default: 0
    t.integer "apps_accepted", default: 0
    t.integer "hours_worked", default: 0
    t.float "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text "medical_conditions"
    t.string "provider"
    t.string "uid"
    t.string "stripe_customer_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

  create_table "volunteer_preferred_departments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "user_id"
    t.uuid "job_department_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_department_id"], name: "index_volunteer_preferred_departments_on_job_department_id"
    t.index ["user_id"], name: "index_volunteer_preferred_departments_on_user_id"
  end

end
