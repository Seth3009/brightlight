# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20181210072310) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "academic_terms", force: :cascade do |t|
    t.integer  "academic_year_id"
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "academic_terms", ["academic_year_id"], name: "index_academic_terms_on_academic_year_id", using: :btree

  create_table "academic_terms_courses", id: false, force: :cascade do |t|
    t.integer "academic_term_id"
    t.integer "course_id"
  end

  add_index "academic_terms_courses", ["academic_term_id"], name: "index_academic_terms_courses_on_academic_term_id", using: :btree
  add_index "academic_terms_courses", ["course_id"], name: "index_academic_terms_courses_on_course_id", using: :btree

  create_table "academic_years", force: :cascade do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  add_index "academic_years", ["slug"], name: "index_academic_years_on_slug", unique: true, using: :btree

  create_table "account_departments", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "department_id"
    t.string   "notes"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "account_departments", ["account_id"], name: "index_account_departments_on_account_id", using: :btree
  add_index "account_departments", ["department_id"], name: "index_account_departments_on_department_id", using: :btree

  create_table "accounts", force: :cascade do |t|
    t.string   "acc_l1"
    t.string   "acc_l2"
    t.string   "acc_l3"
    t.string   "acc_l4"
    t.string   "description"
    t.string   "notes"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "activity_schedules", force: :cascade do |t|
    t.string   "activity"
    t.date     "start_date"
    t.date     "end_date"
    t.time     "sun_start",        default: '2000-01-01 00:00:00'
    t.time     "sun_end",          default: '2000-01-01 00:00:00'
    t.time     "mon_start",        default: '2000-01-01 00:00:00'
    t.time     "mon_end",          default: '2000-01-01 00:00:00'
    t.time     "tue_start",        default: '2000-01-01 00:00:00'
    t.time     "tue_end",          default: '2000-01-01 00:00:00'
    t.time     "wed_start",        default: '2000-01-01 00:00:00'
    t.time     "wed_end",          default: '2000-01-01 00:00:00'
    t.time     "thu_start",        default: '2000-01-01 00:00:00'
    t.time     "thu_end",          default: '2000-01-01 00:00:00'
    t.time     "fri_start",        default: '2000-01-01 00:00:00'
    t.time     "fri_end",          default: '2000-01-01 00:00:00'
    t.time     "sat_start",        default: '2000-01-01 00:00:00'
    t.time     "sat_end",          default: '2000-01-01 00:00:00'
    t.boolean  "is_active",        default: true
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.integer  "academic_year_id"
  end

  add_index "activity_schedules", ["academic_year_id"], name: "index_activity_schedules_on_academic_year_id", using: :btree

  create_table "attachment_types", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "badges", force: :cascade do |t|
    t.string   "code"
    t.string   "detail"
    t.integer  "student_id"
    t.integer  "employee_id"
    t.string   "kind"
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "book_assignments", id: false, force: :cascade do |t|
    t.integer  "book_copy_id"
    t.integer  "student_id"
    t.integer  "academic_year_id"
    t.integer  "course_text_id"
    t.date     "issue_date"
    t.date     "return_date"
    t.integer  "initial_condition_id"
    t.integer  "end_condition_id"
    t.integer  "status_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "grade_section_id"
  end

  add_index "book_assignments", ["academic_year_id"], name: "index_book_assignments_on_academic_year_id", using: :btree
  add_index "book_assignments", ["book_copy_id"], name: "index_book_assignments_on_book_copy_id", using: :btree
  add_index "book_assignments", ["course_text_id"], name: "index_book_assignments_on_course_text_id", using: :btree
  add_index "book_assignments", ["grade_section_id"], name: "index_book_assignments_on_grade_section_id", using: :btree
  add_index "book_assignments", ["status_id"], name: "index_book_assignments_on_status_id", using: :btree
  add_index "book_assignments", ["student_id"], name: "index_book_assignments_on_student_id", using: :btree

  create_table "book_categories", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "book_conditions", force: :cascade do |t|
    t.string   "code"
    t.string   "description"
    t.integer  "order_no"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "color"
    t.string   "slug"
  end

  add_index "book_conditions", ["slug"], name: "index_book_conditions_on_slug", unique: true, using: :btree

  create_table "book_copies", force: :cascade do |t|
    t.integer  "book_edition_id"
    t.integer  "book_condition_id"
    t.integer  "status_id"
    t.string   "barcode"
    t.string   "copy_no"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "book_label_id"
    t.string   "slug"
    t.boolean  "needs_repair"
    t.string   "notes"
    t.boolean  "disposed"
    t.date     "disposed_at"
  end

  add_index "book_copies", ["barcode"], name: "index_book_copies_on_barcode", unique: true, using: :btree
  add_index "book_copies", ["book_condition_id"], name: "index_book_copies_on_book_condition_id", using: :btree
  add_index "book_copies", ["book_edition_id"], name: "index_book_copies_on_book_edition_id", using: :btree
  add_index "book_copies", ["book_label_id"], name: "index_book_copies_on_book_label_id", using: :btree
  add_index "book_copies", ["slug"], name: "index_book_copies_on_slug", unique: true, using: :btree
  add_index "book_copies", ["status_id"], name: "index_book_copies_on_status_id", using: :btree

  create_table "book_editions", force: :cascade do |t|
    t.string   "google_book_id"
    t.string   "isbndb_id"
    t.string   "title"
    t.string   "subtitle"
    t.string   "authors"
    t.string   "publisher"
    t.string   "published_date"
    t.string   "description"
    t.string   "isbn10"
    t.string   "isbn13"
    t.integer  "page_count"
    t.string   "small_thumbnail"
    t.string   "thumbnail"
    t.string   "language"
    t.string   "edition_info"
    t.string   "tags"
    t.string   "subjects"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "book_title_id"
    t.decimal  "price"
    t.string   "currency"
    t.integer  "attachment_index"
    t.string   "attachment_name"
    t.integer  "attachment_qty"
    t.string   "refno"
    t.string   "slug"
    t.string   "legacy_code"
  end

  add_index "book_editions", ["book_title_id"], name: "index_book_editions_on_book_title_id", using: :btree
  add_index "book_editions", ["slug"], name: "index_book_editions_on_slug", unique: true, using: :btree

  create_table "book_fines", force: :cascade do |t|
    t.integer  "book_copy_id"
    t.integer  "old_condition_id"
    t.integer  "new_condition_id"
    t.decimal  "fine"
    t.integer  "academic_year_id"
    t.integer  "student_id"
    t.string   "status"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.float    "percentage"
    t.string   "currency"
    t.integer  "grade_level_id"
    t.integer  "grade_section_id"
    t.integer  "student_book_id"
    t.boolean  "paid"
  end

  add_index "book_fines", ["academic_year_id"], name: "index_book_fines_on_academic_year_id", using: :btree
  add_index "book_fines", ["book_copy_id"], name: "index_book_fines_on_book_copy_id", using: :btree
  add_index "book_fines", ["grade_level_id"], name: "index_book_fines_on_grade_level_id", using: :btree
  add_index "book_fines", ["grade_section_id"], name: "index_book_fines_on_grade_section_id", using: :btree
  add_index "book_fines", ["student_book_id"], name: "index_book_fines_on_student_book_id", using: :btree
  add_index "book_fines", ["student_id"], name: "index_book_fines_on_student_id", using: :btree

  create_table "book_labels", force: :cascade do |t|
    t.integer  "grade_level_id"
    t.integer  "student_id"
    t.string   "name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "grade_section_id"
    t.string   "slug"
    t.integer  "book_no"
  end

  add_index "book_labels", ["grade_level_id"], name: "index_book_labels_on_grade_level_id", using: :btree
  add_index "book_labels", ["grade_section_id"], name: "index_book_labels_on_grade_section_id", using: :btree
  add_index "book_labels", ["slug"], name: "index_book_labels_on_slug", unique: true, using: :btree
  add_index "book_labels", ["student_id"], name: "index_book_labels_on_student_id", using: :btree

  create_table "book_loan_histories", force: :cascade do |t|
    t.integer  "book_title_id"
    t.integer  "book_edition_id"
    t.integer  "book_copy_id"
    t.integer  "user_id"
    t.date     "out_date"
    t.date     "due_date"
    t.date     "in_date"
    t.integer  "condition_out_id"
    t.integer  "condition_in_id"
    t.float    "fine_assessed"
    t.float    "fine_paid"
    t.float    "fine_waived"
    t.string   "remarks"
    t.integer  "academic_year_id"
    t.integer  "update_by_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "book_loan_histories", ["academic_year_id"], name: "index_book_loan_histories_on_academic_year_id", using: :btree
  add_index "book_loan_histories", ["book_copy_id"], name: "index_book_loan_histories_on_book_copy_id", using: :btree
  add_index "book_loan_histories", ["book_edition_id"], name: "index_book_loan_histories_on_book_edition_id", using: :btree
  add_index "book_loan_histories", ["book_title_id"], name: "index_book_loan_histories_on_book_title_id", using: :btree
  add_index "book_loan_histories", ["condition_in_id"], name: "index_book_loan_histories_on_condition_in_id", using: :btree
  add_index "book_loan_histories", ["condition_out_id"], name: "index_book_loan_histories_on_condition_out_id", using: :btree
  add_index "book_loan_histories", ["update_by_id"], name: "index_book_loan_histories_on_update_by_id", using: :btree
  add_index "book_loan_histories", ["user_id"], name: "index_book_loan_histories_on_user_id", using: :btree

  create_table "book_loans", force: :cascade do |t|
    t.integer  "book_copy_id"
    t.integer  "book_edition_id"
    t.integer  "book_title_id"
    t.integer  "person_id"
    t.integer  "book_category_id"
    t.integer  "loan_type_id"
    t.date     "out_date"
    t.date     "due_date"
    t.integer  "academic_year_id"
    t.integer  "user_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "student_no"
    t.string   "roster_no"
    t.string   "barcode"
    t.string   "refno"
    t.string   "grade_section_code"
    t.string   "grade_subject_code"
    t.string   "notes"
    t.integer  "prev_academic_year_id"
    t.string   "loan_status"
    t.string   "return_status"
    t.string   "bkudid"
    t.date     "return_date"
    t.integer  "employee_id"
    t.string   "employee_no"
    t.integer  "student_id"
    t.boolean  "deleted_flag"
  end

  add_index "book_loans", ["academic_year_id"], name: "index_book_loans_on_academic_year_id", using: :btree
  add_index "book_loans", ["book_category_id"], name: "index_book_loans_on_book_category_id", using: :btree
  add_index "book_loans", ["book_copy_id"], name: "index_book_loans_on_book_copy_id", using: :btree
  add_index "book_loans", ["book_edition_id"], name: "index_book_loans_on_book_edition_id", using: :btree
  add_index "book_loans", ["book_title_id"], name: "index_book_loans_on_book_title_id", using: :btree
  add_index "book_loans", ["employee_id"], name: "index_book_loans_on_employee_id", using: :btree
  add_index "book_loans", ["loan_type_id"], name: "index_book_loans_on_loan_type_id", using: :btree
  add_index "book_loans", ["person_id"], name: "index_book_loans_on_person_id", using: :btree
  add_index "book_loans", ["prev_academic_year_id"], name: "index_book_loans_on_prev_academic_year_id", using: :btree
  add_index "book_loans", ["student_id"], name: "index_book_loans_on_student_id", using: :btree
  add_index "book_loans", ["user_id"], name: "index_book_loans_on_user_id", using: :btree

  create_table "book_receipts", force: :cascade do |t|
    t.integer  "book_copy_id"
    t.integer  "academic_year_id"
    t.integer  "student_id"
    t.integer  "book_edition_id"
    t.integer  "grade_section_id"
    t.integer  "grade_level_id"
    t.integer  "roster_no"
    t.string   "copy_no"
    t.date     "issue_date"
    t.integer  "initial_condition_id"
    t.integer  "return_condition_id"
    t.string   "barcode"
    t.string   "notes"
    t.string   "grade_section_code"
    t.string   "grade_subject_code"
    t.integer  "course_id"
    t.integer  "course_text_id"
    t.boolean  "active"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "book_receipts", ["academic_year_id"], name: "index_book_receipts_on_academic_year_id", using: :btree
  add_index "book_receipts", ["book_copy_id"], name: "index_book_receipts_on_book_copy_id", using: :btree
  add_index "book_receipts", ["book_edition_id"], name: "index_book_receipts_on_book_edition_id", using: :btree
  add_index "book_receipts", ["course_id"], name: "index_book_receipts_on_course_id", using: :btree
  add_index "book_receipts", ["course_text_id"], name: "index_book_receipts_on_course_text_id", using: :btree
  add_index "book_receipts", ["grade_level_id"], name: "index_book_receipts_on_grade_level_id", using: :btree
  add_index "book_receipts", ["grade_section_id"], name: "index_book_receipts_on_grade_section_id", using: :btree
  add_index "book_receipts", ["initial_condition_id"], name: "index_book_receipts_on_initial_condition_id", using: :btree
  add_index "book_receipts", ["return_condition_id"], name: "index_book_receipts_on_return_condition_id", using: :btree
  add_index "book_receipts", ["student_id"], name: "index_book_receipts_on_student_id", using: :btree

  create_table "book_titles", force: :cascade do |t|
    t.string   "title"
    t.string   "authors"
    t.string   "publisher"
    t.string   "image_url"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "bkudid"
    t.integer  "subject_id"
    t.string   "subject_code"
    t.string   "slug"
    t.string   "subject_level"
    t.string   "grade_code"
    t.integer  "grade_level_id"
    t.string   "track"
    t.string   "tags"
  end

  add_index "book_titles", ["grade_level_id"], name: "index_book_titles_on_grade_level_id", using: :btree
  add_index "book_titles", ["slug"], name: "index_book_titles_on_slug", unique: true, using: :btree
  add_index "book_titles", ["subject_id"], name: "index_book_titles_on_subject_id", using: :btree

  create_table "budget_items", force: :cascade do |t|
    t.integer  "budget_id"
    t.string   "description"
    t.string   "account"
    t.integer  "line"
    t.string   "notes"
    t.integer  "month"
    t.decimal  "amount"
    t.decimal  "actual_amt"
    t.boolean  "is_completed"
    t.string   "type"
    t.string   "category"
    t.string   "group"
    t.integer  "created_by_id"
    t.integer  "last_updated_by_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "year"
  end

  add_index "budget_items", ["budget_id"], name: "index_budget_items_on_budget_id", using: :btree
  add_index "budget_items", ["created_by_id"], name: "index_budget_items_on_created_by_id", using: :btree
  add_index "budget_items", ["last_updated_by_id"], name: "index_budget_items_on_last_updated_by_id", using: :btree

  create_table "budgets", force: :cascade do |t|
    t.integer  "department_id"
    t.integer  "grade_level_id"
    t.integer  "grade_section_id"
    t.integer  "budget_holder_id"
    t.integer  "academic_year_id"
    t.boolean  "is_submitted"
    t.date     "submit_date"
    t.boolean  "is_approved"
    t.date     "approved_date"
    t.integer  "approver_id"
    t.boolean  "is_received"
    t.integer  "receiver_id"
    t.date     "received_date"
    t.decimal  "total_amt"
    t.string   "notes"
    t.string   "category"
    t.string   "type"
    t.string   "group"
    t.string   "version"
    t.integer  "created_by_id"
    t.integer  "last_updated_by_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "budgets", ["academic_year_id"], name: "index_budgets_on_academic_year_id", using: :btree
  add_index "budgets", ["approver_id"], name: "index_budgets_on_approver_id", using: :btree
  add_index "budgets", ["budget_holder_id"], name: "index_budgets_on_budget_holder_id", using: :btree
  add_index "budgets", ["created_by_id"], name: "index_budgets_on_created_by_id", using: :btree
  add_index "budgets", ["department_id"], name: "index_budgets_on_department_id", using: :btree
  add_index "budgets", ["last_updated_by_id"], name: "index_budgets_on_last_updated_by_id", using: :btree
  add_index "budgets", ["receiver_id"], name: "index_budgets_on_receiver_id", using: :btree

  create_table "carpools", force: :cascade do |t|
    t.string   "category"
    t.integer  "transport_id"
    t.string   "barcode"
    t.string   "transport_name"
    t.string   "period"
    t.float    "sort_order"
    t.boolean  "active"
    t.string   "status"
    t.datetime "arrival"
    t.datetime "departure"
    t.string   "notes"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "carpools", ["barcode"], name: "index_carpools_on_barcode", using: :btree
  add_index "carpools", ["sort_order"], name: "index_carpools_on_sort_order", using: :btree
  add_index "carpools", ["transport_id"], name: "index_carpools_on_transport_id", using: :btree

  create_table "cars", force: :cascade do |t|
    t.string   "transport_name", limit: 255
    t.string   "uid",            limit: 255
    t.string   "family_no",      limit: 255
    t.integer  "period"
    t.string   "status",         limit: 255
    t.string   "category",       limit: 255
    t.datetime "arrival"
    t.datetime "departure"
    t.boolean  "loading",                    default: false, null: false
    t.float    "sort_order"
    t.string   "notes",          limit: 255
    t.integer  "transport_id"
    t.datetime "inserted_at",                                null: false
    t.datetime "updated_at",                                 null: false
    t.string   "period_hash",    limit: 32
  end

  add_index "cars", ["transport_id", "period_hash"], name: "transport_period_index", unique: true, using: :btree
  add_index "cars", ["transport_id"], name: "cars_transport_id_index", using: :btree

  create_table "comments", force: :cascade do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "role",                        default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "copy_conditions", force: :cascade do |t|
    t.integer  "book_copy_id"
    t.integer  "book_condition_id"
    t.integer  "academic_year_id"
    t.string   "barcode"
    t.string   "notes"
    t.integer  "user_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "post"
    t.boolean  "deleted_flag"
  end

  add_index "copy_conditions", ["academic_year_id"], name: "index_copy_conditions_on_academic_year_id", using: :btree
  add_index "copy_conditions", ["book_condition_id"], name: "index_copy_conditions_on_book_condition_id", using: :btree
  add_index "copy_conditions", ["book_copy_id"], name: "index_copy_conditions_on_book_copy_id", using: :btree
  add_index "copy_conditions", ["user_id"], name: "index_copy_conditions_on_user_id", using: :btree

  create_table "course_section_histories", force: :cascade do |t|
    t.string   "name"
    t.integer  "course_id"
    t.integer  "grade_section_id"
    t.integer  "instructor_id"
    t.integer  "academic_year_id"
    t.integer  "academic_term_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "course_section_histories", ["academic_term_id"], name: "index_course_section_histories_on_academic_term_id", using: :btree
  add_index "course_section_histories", ["academic_year_id"], name: "index_course_section_histories_on_academic_year_id", using: :btree
  add_index "course_section_histories", ["course_id"], name: "index_course_section_histories_on_course_id", using: :btree
  add_index "course_section_histories", ["grade_section_id"], name: "index_course_section_histories_on_grade_section_id", using: :btree
  add_index "course_section_histories", ["instructor_id"], name: "index_course_section_histories_on_instructor_id", using: :btree

  create_table "course_sections", force: :cascade do |t|
    t.string   "name"
    t.integer  "course_id"
    t.integer  "grade_section_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "instructor_id"
    t.string   "slug"
  end

  add_index "course_sections", ["course_id"], name: "index_course_sections_on_course_id", using: :btree
  add_index "course_sections", ["grade_section_id"], name: "index_course_sections_on_grade_section_id", using: :btree
  add_index "course_sections", ["instructor_id"], name: "index_course_sections_on_instructor_id", using: :btree
  add_index "course_sections", ["slug"], name: "index_course_sections_on_slug", unique: true, using: :btree

  create_table "course_texts", force: :cascade do |t|
    t.integer "course_id"
    t.integer "book_title_id"
    t.integer "order_no"
  end

  add_index "course_texts", ["book_title_id"], name: "index_course_texts_on_book_title_id", using: :btree
  add_index "course_texts", ["course_id"], name: "index_course_texts_on_course_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.string   "number"
    t.string   "description"
    t.integer  "grade_level_id"
    t.integer  "academic_year_id"
    t.integer  "academic_term_id"
    t.integer  "employee_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "slug"
  end

  add_index "courses", ["academic_term_id"], name: "index_courses_on_academic_term_id", using: :btree
  add_index "courses", ["academic_year_id"], name: "index_courses_on_academic_year_id", using: :btree
  add_index "courses", ["employee_id"], name: "index_courses_on_employee_id", using: :btree
  add_index "courses", ["grade_level_id"], name: "index_courses_on_grade_level_id", using: :btree
  add_index "courses", ["slug"], name: "index_courses_on_slug", unique: true, using: :btree

  create_table "currencies", force: :cascade do |t|
    t.string   "foreign"
    t.string   "base"
    t.float    "rate"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "currencies", ["user_id"], name: "index_currencies_on_user_id", using: :btree

  create_table "deliveries", force: :cascade do |t|
    t.integer  "purchase_order_id"
    t.date     "delivery_date"
    t.string   "address"
    t.integer  "accepted_by_id"
    t.date     "accepted_date"
    t.integer  "checked_by_id"
    t.date     "checked_date"
    t.string   "notes"
    t.string   "delivery_method"
    t.string   "status"
    t.integer  "created_by_id"
    t.integer  "last_updated_by_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "deliveries", ["accepted_by_id"], name: "index_deliveries_on_accepted_by_id", using: :btree
  add_index "deliveries", ["checked_by_id"], name: "index_deliveries_on_checked_by_id", using: :btree
  add_index "deliveries", ["created_by_id"], name: "index_deliveries_on_created_by_id", using: :btree
  add_index "deliveries", ["last_updated_by_id"], name: "index_deliveries_on_last_updated_by_id", using: :btree
  add_index "deliveries", ["purchase_order_id"], name: "index_deliveries_on_purchase_order_id", using: :btree

  create_table "delivery_items", force: :cascade do |t|
    t.integer  "delivery_id"
    t.integer  "order_item_id"
    t.float    "quantity"
    t.string   "unit"
    t.integer  "accepted_by_id"
    t.date     "accepted_date"
    t.integer  "checked_by_id"
    t.string   "checked_date"
    t.string   "notes"
    t.boolean  "is_accepted"
    t.boolean  "is_rejected"
    t.string   "reject_notes"
    t.string   "accept_notes"
    t.integer  "created_by_id"
    t.integer  "last_updated_by_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "delivery_items", ["accepted_by_id"], name: "index_delivery_items_on_accepted_by_id", using: :btree
  add_index "delivery_items", ["checked_by_id"], name: "index_delivery_items_on_checked_by_id", using: :btree
  add_index "delivery_items", ["created_by_id"], name: "index_delivery_items_on_created_by_id", using: :btree
  add_index "delivery_items", ["delivery_id"], name: "index_delivery_items_on_delivery_id", using: :btree
  add_index "delivery_items", ["last_updated_by_id"], name: "index_delivery_items_on_last_updated_by_id", using: :btree
  add_index "delivery_items", ["order_item_id"], name: "index_delivery_items_on_order_item_id", using: :btree

  create_table "departments", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "manager_id"
    t.string   "slug"
    t.integer  "vice_manager_id"
  end

  add_index "departments", ["manager_id"], name: "index_departments_on_manager_id", using: :btree
  add_index "departments", ["slug"], name: "index_departments_on_slug", unique: true, using: :btree

  create_table "diknas_conversion_items", force: :cascade do |t|
    t.integer  "diknas_conversion_id"
    t.integer  "course_id"
    t.integer  "academic_year_id"
    t.integer  "academic_term_id"
    t.integer  "weight"
    t.text     "notes"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "diknas_conversion_items", ["academic_term_id"], name: "index_diknas_conversion_items_on_academic_term_id", using: :btree
  add_index "diknas_conversion_items", ["academic_year_id"], name: "index_diknas_conversion_items_on_academic_year_id", using: :btree
  add_index "diknas_conversion_items", ["course_id"], name: "index_diknas_conversion_items_on_course_id", using: :btree
  add_index "diknas_conversion_items", ["diknas_conversion_id"], name: "index_diknas_conversion_items_on_diknas_conversion_id", using: :btree

  create_table "diknas_conversions", force: :cascade do |t|
    t.integer  "diknas_course_id"
    t.integer  "academic_year_id"
    t.integer  "academic_term_id"
    t.float    "weight"
    t.text     "notes"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "grade_level_id"
  end

  add_index "diknas_conversions", ["academic_term_id"], name: "index_diknas_conversions_on_academic_term_id", using: :btree
  add_index "diknas_conversions", ["academic_year_id"], name: "index_diknas_conversions_on_academic_year_id", using: :btree
  add_index "diknas_conversions", ["diknas_course_id"], name: "index_diknas_conversions_on_diknas_course_id", using: :btree

  create_table "diknas_converted_items", force: :cascade do |t|
    t.integer  "diknas_converted_id"
    t.integer  "diknas_conversion_id"
    t.float    "p_score"
    t.float    "t_score"
    t.text     "comment"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "diknas_converted_items", ["diknas_conversion_id"], name: "index_diknas_converted_items_on_diknas_conversion_id", using: :btree
  add_index "diknas_converted_items", ["diknas_converted_id"], name: "index_diknas_converted_items_on_diknas_converted_id", using: :btree

  create_table "diknas_converteds", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "academic_year_id"
    t.integer  "academic_term_id"
    t.integer  "grade_level_id"
    t.text     "notes"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "diknas_converteds", ["academic_term_id"], name: "index_diknas_converteds_on_academic_term_id", using: :btree
  add_index "diknas_converteds", ["academic_year_id"], name: "index_diknas_converteds_on_academic_year_id", using: :btree
  add_index "diknas_converteds", ["grade_level_id"], name: "index_diknas_converteds_on_grade_level_id", using: :btree
  add_index "diknas_converteds", ["student_id"], name: "index_diknas_converteds_on_student_id", using: :btree

  create_table "diknas_courses", force: :cascade do |t|
    t.integer  "number"
    t.string   "name"
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "diknas_report_cards", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "grade_level_id"
    t.integer  "grade_section_id"
    t.integer  "academic_year_id"
    t.integer  "academic_term_id"
    t.float    "average"
    t.text     "notes"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "course_id"
  end

  add_index "diknas_report_cards", ["academic_term_id"], name: "index_diknas_report_cards_on_academic_term_id", using: :btree
  add_index "diknas_report_cards", ["academic_year_id"], name: "index_diknas_report_cards_on_academic_year_id", using: :btree
  add_index "diknas_report_cards", ["grade_level_id"], name: "index_diknas_report_cards_on_grade_level_id", using: :btree
  add_index "diknas_report_cards", ["grade_section_id"], name: "index_diknas_report_cards_on_grade_section_id", using: :btree
  add_index "diknas_report_cards", ["student_id"], name: "index_diknas_report_cards_on_student_id", using: :btree

  create_table "door_access_logs", force: :cascade do |t|
    t.string   "location"
    t.string   "card"
    t.integer  "employee_id"
    t.integer  "student_id"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "kind"
  end

  add_index "door_access_logs", ["employee_id"], name: "index_door_access_logs_on_employee_id", using: :btree
  add_index "door_access_logs", ["student_id"], name: "index_door_access_logs_on_student_id", using: :btree

  create_table "employee_smartcards", force: :cascade do |t|
    t.string   "card"
    t.integer  "employee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "employee_smartcards", ["employee_id"], name: "index_employee_smartcards_on_employee_id", using: :btree

  create_table "employees", force: :cascade do |t|
    t.string   "name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.date     "date_of_birth"
    t.string   "place_of_birth"
    t.date     "joining_date"
    t.string   "job_title"
    t.string   "employee_number"
    t.string   "marital_status"
    t.integer  "experience_year"
    t.integer  "experience_month"
    t.string   "employment_status"
    t.integer  "children_count"
    t.string   "home_address_line1"
    t.string   "home_address_line2"
    t.string   "home_city"
    t.string   "home_state"
    t.string   "home_country"
    t.string   "home_postal_code"
    t.string   "mobile_phone"
    t.string   "home_phone"
    t.string   "office_phone"
    t.string   "other_phone"
    t.string   "emergency_contact_number"
    t.string   "emergency_contact_name"
    t.string   "email"
    t.string   "photo_uri"
    t.string   "education_degree"
    t.date     "education_graduation_date"
    t.string   "education_school"
    t.string   "education_degree2"
    t.date     "education_graduation_date2"
    t.string   "education_school2"
    t.string   "nationality"
    t.string   "blood_type"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "supervisor_id"
    t.integer  "department_id"
    t.string   "slug"
    t.string   "nick_name"
    t.boolean  "is_active"
    t.integer  "family_no"
    t.integer  "user_id"
    t.integer  "approver_id"
    t.integer  "approver_assistant_id"
    t.boolean  "leaderships",                default: false
  end

  add_index "employees", ["department_id"], name: "index_employees_on_department_id", using: :btree
  add_index "employees", ["slug"], name: "index_employees_on_slug", unique: true, using: :btree
  add_index "employees", ["supervisor_id"], name: "index_employees_on_supervisor_id", using: :btree
  add_index "employees", ["user_id"], name: "index_employees_on_user_id", using: :btree

  create_table "families", force: :cascade do |t|
    t.string   "family_no"
    t.integer  "family_number"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "families", ["family_no"], name: "index_families_on_family_no", using: :btree
  add_index "families", ["family_number"], name: "index_families_on_family_number", using: :btree

  create_table "family_members", force: :cascade do |t|
    t.integer  "family_id"
    t.integer  "guardian_id"
    t.integer  "student_id"
    t.string   "relation"
    t.string   "notes"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "family_members", ["family_id"], name: "index_family_members_on_family_id", using: :btree
  add_index "family_members", ["guardian_id"], name: "index_family_members_on_guardian_id", using: :btree
  add_index "family_members", ["student_id"], name: "index_family_members_on_student_id", using: :btree

  create_table "fine_scales", force: :cascade do |t|
    t.integer  "old_condition_id"
    t.integer  "new_condition_id"
    t.float    "percentage"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "fine_scales", ["new_condition_id"], name: "index_fine_scales_on_new_condition_id", using: :btree
  add_index "fine_scales", ["old_condition_id"], name: "index_fine_scales_on_old_condition_id", using: :btree

  create_table "grade_levels", force: :cascade do |t|
    t.string   "name"
    t.integer  "order_no"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "school_level_id"
    t.string   "code"
    t.string   "slug"
  end

  add_index "grade_levels", ["school_level_id"], name: "index_grade_levels_on_school_level_id", using: :btree
  add_index "grade_levels", ["slug"], name: "index_grade_levels_on_slug", unique: true, using: :btree

  create_table "grade_section_histories", force: :cascade do |t|
    t.integer  "grade_level_id"
    t.integer  "grade_section_id"
    t.integer  "academic_year_id"
    t.integer  "homeroom_id"
    t.string   "name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "assistant_id"
    t.string   "subject_code"
    t.string   "parallel_code"
    t.string   "notes"
    t.integer  "capacity"
  end

  add_index "grade_section_histories", ["academic_year_id"], name: "index_grade_section_histories_on_academic_year_id", using: :btree
  add_index "grade_section_histories", ["assistant_id"], name: "index_grade_section_histories_on_assistant_id", using: :btree
  add_index "grade_section_histories", ["grade_level_id"], name: "index_grade_section_histories_on_grade_level_id", using: :btree
  add_index "grade_section_histories", ["grade_section_id"], name: "index_grade_section_histories_on_grade_section_id", using: :btree
  add_index "grade_section_histories", ["homeroom_id"], name: "index_grade_section_histories_on_homeroom_id", using: :btree

  create_table "grade_sections", force: :cascade do |t|
    t.integer  "grade_level_id"
    t.string   "name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "homeroom_id"
    t.integer  "academic_year_id"
    t.string   "slug"
    t.integer  "assistant_id"
    t.string   "subject_code"
    t.string   "parallel_code"
    t.string   "notes"
    t.integer  "capacity"
  end

  add_index "grade_sections", ["academic_year_id"], name: "index_grade_sections_on_academic_year_id", using: :btree
  add_index "grade_sections", ["assistant_id"], name: "index_grade_sections_on_assistant_id", using: :btree
  add_index "grade_sections", ["grade_level_id"], name: "index_grade_sections_on_grade_level_id", using: :btree
  add_index "grade_sections", ["homeroom_id"], name: "index_grade_sections_on_homeroom_id", using: :btree
  add_index "grade_sections", ["slug"], name: "index_grade_sections_on_slug", unique: true, using: :btree

  create_table "grade_sections_students", force: :cascade do |t|
    t.integer  "grade_section_id"
    t.integer  "student_id"
    t.integer  "order_no"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "academic_year_id"
    t.integer  "grade_section_history_id"
    t.string   "notes"
    t.string   "track"
  end

  add_index "grade_sections_students", ["academic_year_id"], name: "index_grade_sections_students_on_academic_year_id", using: :btree
  add_index "grade_sections_students", ["grade_section_history_id"], name: "index_grade_sections_students_on_grade_section_history_id", using: :btree
  add_index "grade_sections_students", ["grade_section_id"], name: "index_grade_sections_students_on_grade_section_id", using: :btree
  add_index "grade_sections_students", ["student_id"], name: "index_grade_sections_students_on_student_id", using: :btree

  create_table "gradebook", force: :cascade do |t|
    t.string   "studentname"
    t.string   "grade"
    t.string   "class"
    t.decimal  "avg"
    t.string   "semester"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "guardians", force: :cascade do |t|
    t.string   "name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "mobile_phone"
    t.string   "home_phone"
    t.string   "office_phone"
    t.string   "other_phone"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.string   "country"
    t.integer  "family_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "person_id"
    t.string   "slug"
    t.string   "email"
    t.string   "email2"
  end

  add_index "guardians", ["person_id"], name: "index_guardians_on_person_id", using: :btree
  add_index "guardians", ["slug"], name: "index_guardians_on_slug", unique: true, using: :btree

  create_table "invoices", force: :cascade do |t|
    t.integer  "invoice_number"
    t.date     "invoice_date"
    t.string   "bill_to"
    t.integer  "student_id"
    t.string   "grade_section"
    t.string   "roster_no"
    t.string   "total_amount"
    t.string   "received_by"
    t.string   "paid_by"
    t.string   "paid_amount"
    t.string   "currency"
    t.string   "notes"
    t.boolean  "paid"
    t.string   "statuses"
    t.string   "tag"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "academic_year_id"
  end

  add_index "invoices", ["academic_year_id"], name: "index_invoices_on_academic_year_id", using: :btree
  add_index "invoices", ["student_id"], name: "index_invoices_on_student_id", using: :btree
  add_index "invoices", ["user_id"], name: "index_invoices_on_user_id", using: :btree

  create_table "item_categories", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_units", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "abbreviation"
  end

  create_table "late_passengers", force: :cascade do |t|
    t.integer  "carpool_id"
    t.integer  "transport_id"
    t.integer  "student_id"
    t.integer  "grade_section_id"
    t.string   "name"
    t.string   "family_no"
    t.integer  "family_id"
    t.string   "class_name"
    t.boolean  "active"
    t.string   "notes"
    t.datetime "since_time"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "late_passengers", ["carpool_id"], name: "index_late_passengers_on_carpool_id", using: :btree
  add_index "late_passengers", ["grade_section_id"], name: "index_late_passengers_on_grade_section_id", using: :btree
  add_index "late_passengers", ["student_id"], name: "index_late_passengers_on_student_id", using: :btree
  add_index "late_passengers", ["transport_id"], name: "index_late_passengers_on_transport_id", using: :btree

  create_table "leave_requests", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.string   "hour"
    t.string   "leave_type"
    t.string   "leave_note"
    t.boolean  "leave_subtitute"
    t.text     "subtitute_notes"
    t.boolean  "spv_approval"
    t.date     "spv_date"
    t.text     "spv_notes"
    t.boolean  "hr_approval"
    t.date     "hr_date"
    t.text     "hr_notes"
    t.date     "form_submit_date"
    t.string   "hr_staf_notes"
    t.integer  "employee_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "is_canceled",       default: false
    t.string   "category"
    t.integer  "leave_day",         default: 0
    t.string   "start_time"
    t.string   "end_time"
    t.boolean  "employee_canceled", default: false
  end

  add_index "leave_requests", ["employee_id"], name: "index_leave_requests_on_employee_id", using: :btree

  create_table "line_items", force: :cascade do |t|
    t.string   "description"
    t.string   "quantity"
    t.string   "price"
    t.string   "ext1"
    t.string   "ext2"
    t.string   "ext3"
    t.string   "notes"
    t.string   "status"
    t.integer  "invoice_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "book_fine_id"
  end

  add_index "line_items", ["book_fine_id"], name: "index_line_items_on_book_fine_id", using: :btree
  add_index "line_items", ["invoice_id"], name: "index_line_items_on_invoice_id", using: :btree

  create_table "loan_checks", force: :cascade do |t|
    t.integer  "book_loan_id"
    t.integer  "book_copy_id"
    t.integer  "user_id"
    t.integer  "loaned_to"
    t.integer  "scanned_for"
    t.integer  "academic_year_id"
    t.boolean  "emp_flag"
    t.boolean  "matched"
    t.string   "notes"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "loan_checks", ["academic_year_id"], name: "index_loan_checks_on_academic_year_id", using: :btree
  add_index "loan_checks", ["book_copy_id"], name: "index_loan_checks_on_book_copy_id", using: :btree
  add_index "loan_checks", ["book_loan_id"], name: "index_loan_checks_on_book_loan_id", using: :btree
  add_index "loan_checks", ["user_id"], name: "index_loan_checks_on_user_id", using: :btree

  create_table "loan_types", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "message_recipients", force: :cascade do |t|
    t.integer  "recipient_id"
    t.integer  "msg_group_id"
    t.integer  "message_id"
    t.boolean  "is_read",        default: false
    t.string   "recipient_type"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "message_recipients", ["message_id"], name: "index_message_recipients_on_message_id", using: :btree
  add_index "message_recipients", ["msg_group_id"], name: "index_message_recipients_on_msg_group_id", using: :btree
  add_index "message_recipients", ["recipient_id"], name: "index_message_recipients_on_recipient_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.string   "subject"
    t.integer  "creator_id"
    t.string   "body"
    t.integer  "parent_id"
    t.date     "expiry_date"
    t.boolean  "is_reminder"
    t.date     "next_remind_date"
    t.string   "tags"
    t.integer  "msg_folder_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "messages", ["creator_id"], name: "index_messages_on_creator_id", using: :btree
  add_index "messages", ["msg_folder_id"], name: "index_messages_on_msg_folder_id", using: :btree
  add_index "messages", ["parent_id"], name: "index_messages_on_parent_id", using: :btree

  create_table "msg_folders", force: :cascade do |t|
    t.string   "name"
    t.string   "tag"
    t.integer  "parent_id"
    t.string   "badge"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "msg_folders", ["parent_id"], name: "index_msg_folders_on_parent_id", using: :btree

  create_table "msg_groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "creator_id"
    t.boolean  "is_active",  default: true
    t.string   "image_url"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "msg_groups", ["creator_id"], name: "index_msg_groups_on_creator_id", using: :btree

  create_table "order_items", force: :cascade do |t|
    t.integer  "purchase_order_id"
    t.integer  "stock_item_id"
    t.float    "quantity"
    t.string   "unit"
    t.float    "min_delivery_qty"
    t.float    "pending_qty"
    t.string   "type"
    t.decimal  "line_amount"
    t.decimal  "unit_price"
    t.string   "currency"
    t.boolean  "deleted"
    t.string   "description"
    t.string   "status"
    t.integer  "line_num"
    t.string   "remark"
    t.string   "notes"
    t.integer  "created_by_id"
    t.integer  "last_updated_by_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.decimal  "discount"
    t.decimal  "est_tax"
    t.decimal  "non_recurring"
    t.decimal  "shipping"
    t.decimal  "down_payment"
    t.integer  "req_item_id"
    t.string   "code"
  end

  add_index "order_items", ["created_by_id"], name: "index_order_items_on_created_by_id", using: :btree
  add_index "order_items", ["last_updated_by_id"], name: "index_order_items_on_last_updated_by_id", using: :btree
  add_index "order_items", ["purchase_order_id"], name: "index_order_items_on_purchase_order_id", using: :btree
  add_index "order_items", ["req_item_id"], name: "index_order_items_on_req_item_id", using: :btree
  add_index "order_items", ["stock_item_id"], name: "index_order_items_on_stock_item_id", using: :btree

  create_table "passengers", force: :cascade do |t|
    t.integer  "transport_id"
    t.integer  "student_id"
    t.string   "name"
    t.string   "family_no"
    t.integer  "family_id"
    t.integer  "grade_section_id"
    t.string   "class_name"
    t.boolean  "active"
    t.string   "notes"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "passengers", ["family_no"], name: "index_passengers_on_family_no", using: :btree
  add_index "passengers", ["grade_section_id"], name: "index_passengers_on_grade_section_id", using: :btree
  add_index "passengers", ["student_id"], name: "index_passengers_on_student_id", using: :btree
  add_index "passengers", ["transport_id"], name: "index_passengers_on_transport_id", using: :btree

  create_table "people", force: :cascade do |t|
    t.string   "full_name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "nick_name"
    t.date     "date_of_birth"
    t.string   "place_of_birth"
    t.string   "gender"
    t.string   "passport_no"
    t.string   "blood_type"
    t.string   "mobile_phone"
    t.string   "home_phone"
    t.string   "other_phone"
    t.string   "email"
    t.string   "other_email"
    t.string   "bbm_pin"
    t.string   "sm_twitter"
    t.string   "sm_facebook"
    t.string   "sm_line"
    t.string   "sm_path"
    t.string   "sm_instagram"
    t.string   "sm_google_plus"
    t.string   "sm_linked_in"
    t.string   "gravatar"
    t.string   "photo_uri"
    t.string   "nationality"
    t.string   "religion"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "kecamatan"
    t.string   "kabupaten"
    t.string   "city"
    t.string   "postal_code"
    t.string   "state"
    t.string   "country"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "user_id"
  end

  add_index "people", ["user_id"], name: "index_people_on_user_id", using: :btree

  create_table "po_reqs", force: :cascade do |t|
    t.integer  "purchase_order_id"
    t.integer  "requisition_id"
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "po_reqs", ["purchase_order_id"], name: "index_po_reqs_on_purchase_order_id", using: :btree
  add_index "po_reqs", ["requisition_id"], name: "index_po_reqs_on_requisition_id", using: :btree
  add_index "po_reqs", ["user_id"], name: "index_po_reqs_on_user_id", using: :btree

  create_table "po_statuses", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "products", force: :cascade do |t|
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "expiry_date"
    t.date     "received_date"
    t.boolean  "is_canceled",      default: false
    t.string   "code"
    t.string   "name"
    t.decimal  "price",            default: 0.0
    t.float    "min_stock",        default: 0.0
    t.float    "max_stock",        default: 100.0
    t.string   "stock_type"
    t.integer  "item_unit_id"
    t.integer  "item_category_id"
    t.boolean  "is_active",        default: true
    t.string   "img_url"
    t.float    "packs"
    t.string   "packs_unit"
    t.string   "barcode"
  end

  add_index "products", ["item_category_id"], name: "index_products_on_item_category_id", using: :btree
  add_index "products", ["item_unit_id"], name: "index_products_on_item_unit_id", using: :btree

  create_table "purchase_orders", force: :cascade do |t|
    t.string   "order_num"
    t.integer  "department_id"
    t.integer  "requestor_id"
    t.integer  "approver_id"
    t.date     "order_date"
    t.date     "due_date"
    t.decimal  "total_amount"
    t.boolean  "is_active"
    t.string   "currency"
    t.boolean  "deleted"
    t.string   "notes"
    t.string   "appvl_notes"
    t.date     "completed_date"
    t.integer  "supplier_id"
    t.string   "contact"
    t.string   "phone_contact"
    t.string   "status"
    t.string   "extra1"
    t.string   "extra2"
    t.integer  "created_by_id"
    t.integer  "last_updated_by_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.decimal  "subtotal"
    t.decimal  "discounts"
    t.decimal  "est_tax"
    t.decimal  "non_recurring"
    t.decimal  "shipping"
    t.decimal  "down_payment"
    t.integer  "buyer_id"
    t.string   "instructions"
    t.string   "fob"
    t.string   "method"
    t.string   "delivery"
    t.integer  "term_of_payment_id"
    t.string   "description"
    t.string   "dlvry_address"
    t.string   "dlvry_address2"
    t.string   "dlvry_city"
    t.string   "dlvry_post_code"
  end

  add_index "purchase_orders", ["approver_id"], name: "index_purchase_orders_on_approver_id", using: :btree
  add_index "purchase_orders", ["buyer_id"], name: "index_purchase_orders_on_buyer_id", using: :btree
  add_index "purchase_orders", ["created_by_id"], name: "index_purchase_orders_on_created_by_id", using: :btree
  add_index "purchase_orders", ["last_updated_by_id"], name: "index_purchase_orders_on_last_updated_by_id", using: :btree
  add_index "purchase_orders", ["requestor_id"], name: "index_purchase_orders_on_requestor_id", using: :btree
  add_index "purchase_orders", ["term_of_payment_id"], name: "index_purchase_orders_on_term_of_payment_id", using: :btree

  create_table "recurring_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reminders", force: :cascade do |t|
    t.integer  "recurring_type_id"
    t.integer  "message_id"
    t.integer  "separation_count"
    t.integer  "max_num"
    t.integer  "day_of_week"
    t.integer  "week_of_month"
    t.integer  "day_of_month"
    t.integer  "month_of_year"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "reminders", ["message_id"], name: "index_reminders_on_message_id", using: :btree
  add_index "reminders", ["recurring_type_id"], name: "index_reminders_on_recurring_type_id", using: :btree

  create_table "req_items", force: :cascade do |t|
    t.integer  "requisition_id"
    t.string   "description"
    t.float    "qty_reqd"
    t.string   "unit"
    t.decimal  "est_price"
    t.decimal  "actual_price"
    t.string   "currency"
    t.string   "notes"
    t.float    "qty_ordered"
    t.date     "order_date"
    t.float    "qty_delivered"
    t.date     "delivery_date"
    t.float    "qty_accepted"
    t.date     "acceptance_date"
    t.float    "qty_rejected"
    t.date     "needed_by_date"
    t.string   "acceptance_notes"
    t.string   "reject_notes"
    t.integer  "created_by_id"
    t.integer  "last_updated_by_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "order_item_id"
  end

  add_index "req_items", ["created_by_id"], name: "index_req_items_on_created_by_id", using: :btree
  add_index "req_items", ["last_updated_by_id"], name: "index_req_items_on_last_updated_by_id", using: :btree
  add_index "req_items", ["order_item_id"], name: "index_req_items_on_order_item_id", using: :btree
  add_index "req_items", ["requisition_id"], name: "index_req_items_on_requisition_id", using: :btree

  create_table "req_statuses", force: :cascade do |t|
    t.string   "code"
    t.string   "desription"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requisitions", force: :cascade do |t|
    t.string   "req_no"
    t.string   "description"
    t.boolean  "is_budgeted"
    t.integer  "budget_id"
    t.integer  "budget_item_id"
    t.string   "budget_notes"
    t.date     "date_required"
    t.date     "date_requested"
    t.integer  "department_id"
    t.integer  "requester_id"
    t.integer  "supervisor_id"
    t.string   "notes"
    t.string   "req_appvl_notes"
    t.integer  "req_approver_id"
    t.string   "total_amt"
    t.boolean  "is_budget_approved"
    t.boolean  "is_submitted"
    t.integer  "budget_approver_id"
    t.string   "bgt_appvl_notes"
    t.boolean  "is_rejected"
    t.string   "reject_reason"
    t.integer  "purch_receiver_id"
    t.string   "receive_notes"
    t.boolean  "active"
    t.integer  "created_by_id"
    t.integer  "last_updated_by_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.boolean  "is_supv_approved"
    t.date     "budget_approved_date"
    t.date     "supv_approved_date"
    t.date     "sent_to_supv"
    t.date     "sent_to_purchasing"
    t.date     "sent_for_bgt_approval"
    t.string   "status"
    t.integer  "account_id"
  end

  add_index "requisitions", ["account_id"], name: "index_requisitions_on_account_id", using: :btree
  add_index "requisitions", ["budget_approver_id"], name: "index_requisitions_on_budget_approver_id", using: :btree
  add_index "requisitions", ["budget_id"], name: "index_requisitions_on_budget_id", using: :btree
  add_index "requisitions", ["budget_item_id"], name: "index_requisitions_on_budget_item_id", using: :btree
  add_index "requisitions", ["created_by_id"], name: "index_requisitions_on_created_by_id", using: :btree
  add_index "requisitions", ["department_id"], name: "index_requisitions_on_department_id", using: :btree
  add_index "requisitions", ["last_updated_by_id"], name: "index_requisitions_on_last_updated_by_id", using: :btree
  add_index "requisitions", ["purch_receiver_id"], name: "index_requisitions_on_purch_receiver_id", using: :btree
  add_index "requisitions", ["req_approver_id"], name: "index_requisitions_on_req_approver_id", using: :btree
  add_index "requisitions", ["requester_id"], name: "index_requisitions_on_requester_id", using: :btree
  add_index "requisitions", ["supervisor_id"], name: "index_requisitions_on_supervisor_id", using: :btree

  create_table "room_accesses", force: :cascade do |t|
    t.integer  "room_id"
    t.integer  "badge_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "room_accesses", ["badge_id"], name: "index_room_accesses_on_badge_id", using: :btree
  add_index "room_accesses", ["room_id"], name: "index_room_accesses_on_room_id", using: :btree

  create_table "rooms", force: :cascade do |t|
    t.string   "room_code"
    t.string   "room_name"
    t.string   "location"
    t.string   "ip_address"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "public_access", default: false
  end

  create_table "rosters", force: :cascade do |t|
    t.integer  "course_section_id"
    t.integer  "student_id"
    t.integer  "academic_year_id"
    t.integer  "order_no"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "rosters", ["academic_year_id"], name: "index_rosters_on_academic_year_id", using: :btree
  add_index "rosters", ["course_section_id"], name: "index_rosters_on_course_section_id", using: :btree
  add_index "rosters", ["student_id"], name: "index_rosters_on_student_id", using: :btree

  create_table "schema_versions", primary_key: "version", force: :cascade do |t|
    t.datetime "inserted_at"
  end

  create_table "school_levels", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "school_terms", force: :cascade do |t|
    t.integer  "academic_year_id"
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "school_terms", ["academic_year_id"], name: "index_school_terms_on_academic_year_id", using: :btree

  create_table "school_years", force: :cascade do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "smart_cards", force: :cascade do |t|
    t.string   "code"
    t.integer  "transport_id"
    t.string   "detail"
    t.string   "ref"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "smart_cards", ["transport_id"], name: "index_smart_cards_on_transport_id", using: :btree

  create_table "standard_books", force: :cascade do |t|
    t.integer  "book_title_id"
    t.integer  "book_edition_id"
    t.integer  "book_category_id"
    t.integer  "grade_level_id"
    t.integer  "grade_section_id"
    t.integer  "academic_year_id"
    t.string   "isbn"
    t.string   "refno"
    t.integer  "quantity"
    t.string   "grade_subject_code"
    t.string   "grade_name"
    t.string   "group"
    t.string   "category"
    t.string   "bkudid"
    t.string   "notes"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "track"
    t.integer  "subject_id"
  end

  add_index "standard_books", ["academic_year_id"], name: "index_standard_books_on_academic_year_id", using: :btree
  add_index "standard_books", ["book_category_id"], name: "index_standard_books_on_book_category_id", using: :btree
  add_index "standard_books", ["book_edition_id"], name: "index_standard_books_on_book_edition_id", using: :btree
  add_index "standard_books", ["book_title_id"], name: "index_standard_books_on_book_title_id", using: :btree
  add_index "standard_books", ["grade_level_id"], name: "index_standard_books_on_grade_level_id", using: :btree
  add_index "standard_books", ["grade_section_id"], name: "index_standard_books_on_grade_section_id", using: :btree
  add_index "standard_books", ["subject_id"], name: "index_standard_books_on_subject_id", using: :btree

  create_table "statuses", force: :cascade do |t|
    t.string  "name"
    t.integer "order_no"
  end

  create_table "stock_categories", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.string   "description"
    t.string   "type"
    t.boolean  "is_active"
    t.string   "location"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "stock_items", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.string   "uuid"
    t.string   "description"
    t.string   "tags"
    t.string   "short_desc"
    t.boolean  "is_active"
    t.decimal  "unit_price"
    t.binary   "image"
    t.integer  "stock_category_id"
    t.string   "stock_class"
    t.string   "group"
    t.string   "weight"
    t.string   "extra1"
    t.string   "extra2"
    t.integer  "created_by_id"
    t.integer  "last_updated_by_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "stock_items", ["created_by_id"], name: "index_stock_items_on_created_by_id", using: :btree
  add_index "stock_items", ["last_updated_by_id"], name: "index_stock_items_on_last_updated_by_id", using: :btree

  create_table "student_activities", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "activity_schedule_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "academic_year_id"
  end

  add_index "student_activities", ["academic_year_id"], name: "index_student_activities_on_academic_year_id", using: :btree
  add_index "student_activities", ["activity_schedule_id"], name: "index_student_activities_on_activity_schedule_id", using: :btree
  add_index "student_activities", ["student_id"], name: "index_student_activities_on_student_id", using: :btree

  create_table "student_admission_infos", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "academic_year_id"
    t.string   "skhun"
    t.string   "skhun_date"
    t.string   "diploma"
    t.string   "diploma_date"
    t.string   "acceptance_date_1"
    t.string   "acceptance_date_2"
    t.string   "nisn"
    t.string   "duration"
    t.string   "reason"
    t.string   "status"
    t.string   "notes"
    t.string   "prev_sch_name"
    t.string   "prev_sch_grade"
    t.string   "prev_sch_address"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "student_admission_infos", ["academic_year_id"], name: "index_student_admission_infos_on_academic_year_id", using: :btree
  add_index "student_admission_infos", ["student_id"], name: "index_student_admission_infos_on_student_id", using: :btree

  create_table "student_books", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "book_copy_id"
    t.integer  "academic_year_id"
    t.integer  "course_text_id"
    t.string   "copy_no"
    t.integer  "grade_section_id"
    t.integer  "grade_level_id"
    t.integer  "course_id"
    t.date     "issue_date"
    t.date     "return_date"
    t.integer  "initial_copy_condition_id"
    t.integer  "end_copy_condition_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "barcode"
    t.string   "student_no"
    t.string   "roster_no"
    t.string   "grade_section_code"
    t.string   "grade_subject_code"
    t.string   "notes"
    t.integer  "prev_academic_year_id"
    t.integer  "book_edition_id"
    t.boolean  "deleted_flag"
    t.boolean  "needs_rebinding"
    t.integer  "book_loan_id"
  end

  add_index "student_books", ["academic_year_id"], name: "index_student_books_on_academic_year_id", using: :btree
  add_index "student_books", ["book_copy_id"], name: "index_student_books_on_book_copy_id", using: :btree
  add_index "student_books", ["book_edition_id"], name: "index_student_books_on_book_edition_id", using: :btree
  add_index "student_books", ["book_loan_id"], name: "index_student_books_on_book_loan_id", using: :btree
  add_index "student_books", ["course_id"], name: "index_student_books_on_course_id", using: :btree
  add_index "student_books", ["course_text_id"], name: "index_student_books_on_course_text_id", using: :btree
  add_index "student_books", ["grade_level_id"], name: "index_student_books_on_grade_level_id", using: :btree
  add_index "student_books", ["grade_section_id"], name: "index_student_books_on_grade_section_id", using: :btree
  add_index "student_books", ["prev_academic_year_id"], name: "index_student_books_on_prev_academic_year_id", using: :btree
  add_index "student_books", ["student_id"], name: "index_student_books_on_student_id", using: :btree

  create_table "students", force: :cascade do |t|
    t.string   "name"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "date_of_birth"
    t.string   "admission_no"
    t.integer  "family_id"
    t.string   "gender"
    t.string   "blood_type"
    t.string   "nationality"
    t.string   "religion"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.string   "country"
    t.string   "mobile_phone"
    t.string   "home_phone"
    t.string   "email"
    t.string   "photo_uri"
    t.string   "status"
    t.string   "status_description"
    t.boolean  "is_active"
    t.boolean  "is_deleted"
    t.string   "student_no"
    t.string   "passport_no"
    t.string   "enrollment_date"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "person_id"
    t.string   "nick_name"
    t.string   "family_no"
    t.float    "home_to_school_1"
    t.float    "home_to_school_2"
    t.integer  "siblings"
    t.integer  "adopted_siblings"
    t.integer  "step_siblings"
    t.integer  "birth_order"
    t.string   "transport"
    t.string   "parental_status"
    t.string   "parents_status"
    t.string   "address_rt"
    t.string   "address_rw"
    t.string   "address_kelurahan"
    t.string   "address_kecamatan"
    t.string   "living_with"
    t.string   "slug"
    t.string   "place_of_birth"
    t.string   "language"
    t.string   "nisn"
    t.string   "nis"
  end

  add_index "students", ["family_no"], name: "index_students_on_family_no", using: :btree
  add_index "students", ["person_id"], name: "index_students_on_person_id", using: :btree
  add_index "students", ["slug"], name: "index_students_on_slug", unique: true, using: :btree

  create_table "subjects", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "suppliers", force: :cascade do |t|
    t.string   "company_name"
    t.string   "contact_name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "province"
    t.string   "post_code"
    t.string   "country"
    t.string   "phone"
    t.string   "mobile"
    t.string   "email"
    t.string   "website"
    t.string   "notes"
    t.binary   "logo"
    t.string   "category"
    t.string   "status"
    t.string   "type"
    t.string   "group"
    t.string   "code"
    t.integer  "created_by_id"
    t.integer  "last_updated_by_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "fax"
    t.string   "acctg_contact_name"
    t.string   "acctg_phone"
    t.string   "acctg_mobile"
    t.string   "phone2"
    t.string   "mobile2"
    t.string   "bank"
    t.string   "bank_branch"
    t.string   "bank_acct_name"
    t.string   "bank_acct_no"
    t.string   "bank2"
    t.string   "bank2_branch"
    t.string   "bank2_acct_name"
    t.string   "bank2_acct_no"
    t.string   "payment_method"
  end

  add_index "suppliers", ["created_by_id"], name: "index_suppliers_on_created_by_id", using: :btree
  add_index "suppliers", ["last_updated_by_id"], name: "index_suppliers_on_last_updated_by_id", using: :btree

  create_table "supplies_transaction_items", force: :cascade do |t|
    t.integer  "supplies_transaction_id"
    t.integer  "product_id"
    t.string   "in_out",                  default: "OUT"
    t.float    "qty"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "barcode"
    t.integer  "item_unit_id"
    t.integer  "item_category_id"
    t.decimal  "price"
  end

  add_index "supplies_transaction_items", ["product_id"], name: "index_supplies_transaction_items_on_product_id", using: :btree
  add_index "supplies_transaction_items", ["supplies_transaction_id"], name: "index_supplies_transaction_items_on_supplies_transaction_id", using: :btree

  create_table "supplies_transactions", force: :cascade do |t|
    t.date     "transaction_date"
    t.integer  "employee_id"
    t.integer  "itemcount",        default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "card"
    t.string   "notes"
  end

  add_index "supplies_transactions", ["employee_id"], name: "index_supplies_transactions_on_employee_id", using: :btree

  create_table "template_targets", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "templates", force: :cascade do |t|
    t.string   "name"
    t.string   "header"
    t.string   "opening"
    t.string   "body"
    t.string   "closing"
    t.string   "footer"
    t.string   "target"
    t.string   "group"
    t.string   "category"
    t.string   "active"
    t.integer  "academic_year_id"
    t.integer  "user_id"
    t.string   "language"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "templates", ["academic_year_id"], name: "index_templates_on_academic_year_id", using: :btree
  add_index "templates", ["user_id"], name: "index_templates_on_user_id", using: :btree

  create_table "term_of_payments", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "notes"
    t.boolean  "active"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "transports", force: :cascade do |t|
    t.string   "category"
    t.string   "name"
    t.string   "status"
    t.boolean  "active"
    t.string   "notes"
    t.integer  "contact_id"
    t.string   "contact_name"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.string   "family_no"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "transports", ["family_no"], name: "index_transports_on_family_no", using: :btree

  create_table "user_mesg_groups", force: :cascade do |t|
    t.integer  "recipient_id"
    t.integer  "msg_group_id"
    t.boolean  "is_admin",     default: false
    t.boolean  "is_active",    default: true
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "user_mesg_groups", ["msg_group_id"], name: "index_user_mesg_groups_on_msg_group_id", using: :btree
  add_index "user_mesg_groups", ["recipient_id"], name: "index_user_mesg_groups_on_recipient_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "location"
    t.string   "image_url"
    t.string   "url"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "image"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "roles_mask"
    t.string   "auth_token"
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "warehouses", force: :cascade do |t|
    t.string   "name"
    t.string   "room_number"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_foreign_key "account_departments", "accounts"
  add_foreign_key "account_departments", "departments"
  add_foreign_key "activity_schedules", "academic_years"
  add_foreign_key "book_fines", "grade_levels"
  add_foreign_key "book_fines", "grade_sections"
  add_foreign_key "book_fines", "student_books"
  add_foreign_key "book_titles", "grade_levels"
  add_foreign_key "budget_items", "budgets"
  add_foreign_key "budget_items", "users", column: "created_by_id"
  add_foreign_key "budget_items", "users", column: "last_updated_by_id"
  add_foreign_key "budgets", "academic_years"
  add_foreign_key "budgets", "departments"
  add_foreign_key "budgets", "employees", column: "approver_id"
  add_foreign_key "budgets", "employees", column: "budget_holder_id"
  add_foreign_key "budgets", "employees", column: "receiver_id"
  add_foreign_key "budgets", "users", column: "created_by_id"
  add_foreign_key "budgets", "users", column: "last_updated_by_id"
  add_foreign_key "carpools", "transports"
  add_foreign_key "cars", "transports", name: "cars_transport_id_fkey"
  add_foreign_key "course_section_histories", "employees", column: "instructor_id"
  add_foreign_key "currencies", "users"
  add_foreign_key "deliveries", "employees", column: "accepted_by_id"
  add_foreign_key "deliveries", "employees", column: "checked_by_id"
  add_foreign_key "deliveries", "purchase_orders"
  add_foreign_key "deliveries", "users", column: "created_by_id"
  add_foreign_key "deliveries", "users", column: "last_updated_by_id"
  add_foreign_key "delivery_items", "deliveries"
  add_foreign_key "delivery_items", "employees", column: "accepted_by_id"
  add_foreign_key "delivery_items", "employees", column: "checked_by_id"
  add_foreign_key "delivery_items", "order_items"
  add_foreign_key "delivery_items", "users", column: "created_by_id"
  add_foreign_key "delivery_items", "users", column: "last_updated_by_id"
  add_foreign_key "diknas_conversion_items", "academic_terms"
  add_foreign_key "diknas_conversion_items", "academic_years"
  add_foreign_key "diknas_conversion_items", "courses"
  add_foreign_key "diknas_conversion_items", "diknas_conversions"
  add_foreign_key "diknas_conversions", "academic_terms"
  add_foreign_key "diknas_conversions", "academic_years"
  add_foreign_key "diknas_conversions", "diknas_courses"
  add_foreign_key "diknas_conversions", "grade_levels"
  add_foreign_key "diknas_converted_items", "diknas_conversions"
  add_foreign_key "diknas_converted_items", "diknas_converteds"
  add_foreign_key "diknas_converteds", "academic_terms"
  add_foreign_key "diknas_converteds", "academic_years"
  add_foreign_key "diknas_converteds", "grade_levels"
  add_foreign_key "diknas_converteds", "students"
  add_foreign_key "diknas_report_cards", "academic_terms"
  add_foreign_key "diknas_report_cards", "academic_years"
  add_foreign_key "diknas_report_cards", "courses"
  add_foreign_key "diknas_report_cards", "grade_levels"
  add_foreign_key "diknas_report_cards", "grade_sections"
  add_foreign_key "diknas_report_cards", "students"
  add_foreign_key "door_access_logs", "employees"
  add_foreign_key "door_access_logs", "students"
  add_foreign_key "employee_smartcards", "employees"
  add_foreign_key "family_members", "families"
  add_foreign_key "family_members", "guardians"
  add_foreign_key "family_members", "students"
  add_foreign_key "invoices", "academic_years"
  add_foreign_key "invoices", "students"
  add_foreign_key "invoices", "users"
  add_foreign_key "late_passengers", "carpools"
  add_foreign_key "late_passengers", "grade_sections"
  add_foreign_key "late_passengers", "students"
  add_foreign_key "late_passengers", "transports"
  add_foreign_key "leave_requests", "employees"
  add_foreign_key "line_items", "book_fines"
  add_foreign_key "line_items", "invoices"
  add_foreign_key "loan_checks", "academic_years"
  add_foreign_key "loan_checks", "book_copies"
  add_foreign_key "loan_checks", "book_loans"
  add_foreign_key "loan_checks", "users"
  add_foreign_key "message_recipients", "messages"
  add_foreign_key "message_recipients", "msg_groups"
  add_foreign_key "message_recipients", "users", column: "recipient_id"
  add_foreign_key "messages", "users", column: "creator_id"
  add_foreign_key "msg_folders", "msg_folders", column: "parent_id"
  add_foreign_key "msg_groups", "users", column: "creator_id"
  add_foreign_key "order_items", "purchase_orders"
  add_foreign_key "order_items", "req_items"
  add_foreign_key "order_items", "stock_items"
  add_foreign_key "order_items", "users", column: "created_by_id"
  add_foreign_key "order_items", "users", column: "last_updated_by_id"
  add_foreign_key "passengers", "grade_sections"
  add_foreign_key "passengers", "students"
  add_foreign_key "passengers", "transports"
  add_foreign_key "po_reqs", "purchase_orders"
  add_foreign_key "po_reqs", "requisitions"
  add_foreign_key "po_reqs", "users"
  add_foreign_key "purchase_orders", "departments"
  add_foreign_key "purchase_orders", "employees", column: "approver_id"
  add_foreign_key "purchase_orders", "employees", column: "requestor_id"
  add_foreign_key "purchase_orders", "suppliers"
  add_foreign_key "purchase_orders", "users", column: "created_by_id"
  add_foreign_key "purchase_orders", "users", column: "last_updated_by_id"
  add_foreign_key "reminders", "messages"
  add_foreign_key "reminders", "recurring_types"
  add_foreign_key "req_items", "order_items"
  add_foreign_key "req_items", "requisitions"
  add_foreign_key "req_items", "users", column: "created_by_id"
  add_foreign_key "req_items", "users", column: "last_updated_by_id"
  add_foreign_key "requisitions", "accounts"
  add_foreign_key "requisitions", "budget_items"
  add_foreign_key "requisitions", "budgets"
  add_foreign_key "requisitions", "departments"
  add_foreign_key "requisitions", "employees", column: "budget_approver_id"
  add_foreign_key "requisitions", "employees", column: "purch_receiver_id"
  add_foreign_key "requisitions", "employees", column: "req_approver_id"
  add_foreign_key "requisitions", "employees", column: "requester_id"
  add_foreign_key "requisitions", "employees", column: "supervisor_id"
  add_foreign_key "requisitions", "users", column: "created_by_id"
  add_foreign_key "requisitions", "users", column: "last_updated_by_id"
  add_foreign_key "room_accesses", "badges"
  add_foreign_key "room_accesses", "rooms"
  add_foreign_key "smart_cards", "transports"
  add_foreign_key "standard_books", "subjects"
  add_foreign_key "student_activities", "academic_years"
  add_foreign_key "student_activities", "activity_schedules"
  add_foreign_key "student_activities", "students"
  add_foreign_key "supplies_transaction_items", "item_categories"
  add_foreign_key "supplies_transaction_items", "item_units"
  add_foreign_key "supplies_transaction_items", "products"
  add_foreign_key "supplies_transaction_items", "supplies_transactions"
  add_foreign_key "supplies_transactions", "employees"
  add_foreign_key "templates", "academic_years"
  add_foreign_key "templates", "users"
  add_foreign_key "user_mesg_groups", "msg_groups"
  add_foreign_key "user_mesg_groups", "users", column: "recipient_id"

  create_view :teachers_books,  sql_definition: <<-SQL
      SELECT book_loans.id,
      book_loans.book_copy_id,
      book_loans.book_edition_id,
      book_loans.book_title_id,
      book_loans.person_id,
      book_loans.book_category_id,
      book_loans.loan_type_id,
      book_loans.out_date,
      book_loans.due_date,
      book_loans.academic_year_id,
      book_loans.user_id,
      book_loans.created_at,
      book_loans.updated_at,
      book_loans.student_no,
      book_loans.roster_no,
      book_loans.barcode,
      book_loans.refno,
      book_loans.grade_section_code,
      book_loans.grade_subject_code,
      book_loans.notes,
      book_loans.prev_academic_year_id,
      book_loans.loan_status,
      book_loans.return_status,
      book_loans.bkudid,
      book_loans.return_date,
      book_loans.employee_id,
      book_loans.employee_no,
      book_loans.student_id,
      book_loans.deleted_flag,
      subjects.name AS subject,
      book_titles.subject_id,
      book_titles.tags,
      book_titles.id AS title_id,
      e.id AS edition_id,
      e.title,
      e.authors,
      e.isbn10,
      e.isbn13,
      e.publisher,
      e.small_thumbnail,
      c.code AS catg_code,
      c.name AS catg_name,
      l.id AS check_id,
      l.user_id AS checked_by,
      l.loaned_to,
      l.scanned_for,
      l.emp_flag,
      l.matched,
      l.notes AS check_notes,
      employees.id AS emp_id,
      employees.name AS emp_name
     FROM ((((((((book_loans
       JOIN book_copies ON (((book_copies.id = book_loans.book_copy_id) AND ((book_copies.disposed = false) OR (book_copies.disposed IS NULL)))))
       LEFT JOIN book_titles ON ((book_titles.id = book_loans.book_title_id)))
       LEFT JOIN book_editions e ON ((e.id = book_loans.book_edition_id)))
       LEFT JOIN book_categories c ON ((c.id = book_loans.book_category_id)))
       LEFT JOIN subjects ON ((subjects.id = book_titles.subject_id)))
       LEFT JOIN employees ON ((employees.id = book_loans.employee_id)))
       LEFT JOIN ( SELECT loan_checks.book_loan_id,
              loan_checks.academic_year_id,
              max(loan_checks.created_at) AS max_date
             FROM loan_checks
            WHERE (loan_checks.matched = true)
            GROUP BY loan_checks.loaned_to, loan_checks.matched, loan_checks.book_loan_id, loan_checks.academic_year_id) max_dates ON (((max_dates.book_loan_id = book_loans.id) AND (max_dates.academic_year_id = book_loans.academic_year_id))))
       LEFT JOIN loan_checks l ON (((l.book_loan_id = book_loans.id) AND (l.academic_year_id = book_loans.academic_year_id) AND (l.loaned_to = book_loans.employee_id) AND (l.matched = true) AND (max_dates.book_loan_id = l.book_loan_id) AND (max_dates.max_date = l.created_at))));
  SQL

end
