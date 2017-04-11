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

ActiveRecord::Schema.define(version: 20170411060140) do

  create_table "labels", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "scope_kind_id"
    t.integer  "node_id"
  end

  add_index "labels", ["node_id"], name: "index_labels_on_node_id"
  add_index "labels", ["scope_kind_id"], name: "index_labels_on_scope_kind_id"

  create_table "node_attributes", force: :cascade do |t|
    t.string   "name"
    t.string   "content"
    t.boolean  "visibility", default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "node_id"
  end

  add_index "node_attributes", ["node_id"], name: "index_node_attributes_on_node_id"

  create_table "node_types", force: :cascade do |t|
    t.string   "name"
    t.string   "totype"
    t.string   "img_link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nodes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
    t.integer  "node_type_id"
    t.string   "type"
    t.integer  "position"
  end

  add_index "nodes", ["node_type_id"], name: "index_nodes_on_node_type_id"
  add_index "nodes", ["project_id"], name: "index_nodes_on_project_id"
  add_index "nodes", ["type"], name: "index_nodes_on_type"

  create_table "nodes_edges", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "source_id"
    t.integer  "destination_id"
    t.integer  "position"
  end

  add_index "nodes_edges", ["destination_id"], name: "index_nodes_edges_on_destination_id"
  add_index "nodes_edges", ["source_id"], name: "index_nodes_edges_on_source_id"

  create_table "project_memberships", force: :cascade do |t|
    t.boolean  "contributor",   default: false
    t.integer  "maximum_layer", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
    t.integer  "user_id"
    t.integer  "role_id"
  end

  add_index "project_memberships", ["project_id"], name: "index_project_memberships_on_project_id"
  add_index "project_memberships", ["role_id"], name: "index_project_memberships_on_role_id"
  add_index "project_memberships", ["user_id"], name: "index_project_memberships_on_user_id"

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.string   "abbrev"
    t.string   "hostnameport"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
    t.string   "prefix"
    t.text     "description"
    t.boolean  "public"
    t.integer  "nodes_count",  default: 0, null: false
  end

  add_index "projects", ["owner_id"], name: "index_projects_on_owner_id"

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "abbrev"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scope_kinds", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "src_format"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "crypted_password",          limit: 40
    t.string   "salt",                      limit: 40
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "name"
    t.string   "email_address"
    t.boolean  "administrator",                        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",                                default: "inactive"
    t.datetime "key_timestamp"
    t.string   "abbrev"
  end

  add_index "users", ["state"], name: "index_users_on_state"

end
