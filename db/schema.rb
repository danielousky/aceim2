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

ActiveRecord::Schema.define(version: 2020_05_25_203626) do

  create_table "academic_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "section_id", null: false
    t.string "agreement_id", null: false
    t.integer "status", null: false
    t.float "final_qualification"
    t.boolean "qualified", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["agreement_id"], name: "index_academic_records_on_agreement_id"
    t.index ["section_id"], name: "index_academic_records_on_section_id"
    t.index ["student_id"], name: "index_academic_records_on_student_id"
  end

  create_table "administrators", primary_key: "user_id", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "role", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_administrators_on_user_id"
  end

  create_table "agreements", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.decimal "value", precision: 10
    t.integer "discount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["id"], name: "index_agreements_on_id"
  end

  create_table "bank_accounts", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "number", null: false
    t.string "holder", null: false
    t.string "bank_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bank_id"], name: "index_bank_accounts_on_bank_id"
    t.index ["id"], name: "index_bank_accounts_on_id"
  end

  create_table "banks", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["id"], name: "index_banks_on_id"
  end

  create_table "careers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "agreement_id", default: "REG", null: false
    t.string "language_id", null: false
    t.bigint "student_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["agreement_id"], name: "index_careers_on_agreement_id"
    t.index ["language_id"], name: "index_careers_on_language_id"
    t.index ["student_id"], name: "index_careers_on_student_id"
  end

  create_table "course_periods", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "period_id", null: false
    t.integer "kind"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_course_periods_on_course_id"
    t.index ["period_id", "course_id"], name: "index_course_periods_on_period_id_and_course_id", unique: true
    t.index ["period_id"], name: "index_course_periods_on_period_id"
  end

  create_table "courses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "language_id", null: false
    t.string "level_id", null: false
    t.integer "grade"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["language_id"], name: "index_courses_on_language_id"
    t.index ["level_id", "language_id"], name: "index_courses_on_level_id_and_language_id", unique: true
    t.index ["level_id"], name: "index_courses_on_level_id"
  end

  create_table "instructors", primary_key: "user_id", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_instructors_on_user_id"
  end

  create_table "items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "languages", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["id"], name: "index_languages_on_id"
  end

  create_table "levels", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["id"], name: "index_levels_on_id"
  end

  create_table "payment_details", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "transaction_number", null: false
    t.string "bank_account_id", null: false
    t.string "source_bank_id"
    t.bigint "academic_record_id"
    t.integer "transaction_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["academic_record_id"], name: "index_payment_details_on_academic_record_id"
    t.index ["bank_account_id"], name: "index_payment_details_on_bank_account_id"
    t.index ["source_bank_id"], name: "index_payment_details_on_source_bank_id"
  end

  create_table "periods", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "year"
    t.string "letter"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "qualification_details", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "section_id", null: false
    t.bigint "qualifier_id", null: false
    t.date "qualification_date"
    t.boolean "qualified", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["qualifier_id"], name: "index_qualification_details_on_qualifier_id"
    t.index ["section_id"], name: "index_qualification_details_on_section_id"
  end

  create_table "sections", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "number", null: false
    t.bigint "course_period_id", null: false
    t.bigint "instructor_id"
    t.bigint "evaluator_id"
    t.boolean "open"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_period_id"], name: "index_sections_on_course_period_id"
    t.index ["evaluator_id"], name: "index_sections_on_evaluator_id"
    t.index ["instructor_id"], name: "index_sections_on_instructor_id"
    t.index ["number", "course_period_id"], name: "index_sections_on_number_and_course_period_id", unique: true
  end

  create_table "students", primary_key: "user_id", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.boolean "active", default: true
    t.string "personal_identity_document"
    t.string "location"
    t.string "source_country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "name"
    t.string "last_name"
    t.string "number_phone"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "academic_records", "agreements", on_update: :cascade, on_delete: :cascade
  add_foreign_key "academic_records", "sections", on_update: :cascade, on_delete: :cascade
  add_foreign_key "academic_records", "students", primary_key: "user_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "administrators", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bank_accounts", "banks", on_update: :cascade, on_delete: :cascade
  add_foreign_key "careers", "agreements", on_update: :cascade, on_delete: :cascade
  add_foreign_key "careers", "languages", on_update: :cascade, on_delete: :cascade
  add_foreign_key "careers", "students", primary_key: "user_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "course_periods", "courses"
  add_foreign_key "course_periods", "periods"
  add_foreign_key "courses", "languages", on_update: :cascade, on_delete: :cascade
  add_foreign_key "courses", "levels", on_update: :cascade, on_delete: :cascade
  add_foreign_key "instructors", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "payment_details", "academic_records", on_update: :cascade, on_delete: :cascade
  add_foreign_key "payment_details", "bank_accounts", on_update: :cascade, on_delete: :cascade
  add_foreign_key "payment_details", "banks", column: "source_bank_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "qualification_details", "instructors", column: "qualifier_id", primary_key: "user_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "qualification_details", "sections", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sections", "course_periods", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sections", "instructors", column: "evaluator_id", primary_key: "user_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sections", "instructors", primary_key: "user_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "students", "users", on_update: :cascade, on_delete: :cascade
end
