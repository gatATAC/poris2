class LibrariesAsNodeAndEdgesAsList < ActiveRecord::Migration
  def self.up
    drop_table :libraries

    change_column :nodes, :type, :string

    add_column :nodes_edges, :position, :integer

    add_index :nodes, [:type]
  end

  def self.down
    change_column :nodes, :type, :integer

    remove_column :nodes_edges, :position

    create_table "libraries", force: :cascade do |t|
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    remove_index :nodes, :name => :index_nodes_on_type rescue ActiveRecord::StatementInvalid
  end
end
