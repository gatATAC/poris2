class AddNodesEdges < ActiveRecord::Migration
  def self.up
    create_table :libraries do |t|
      t.string   :name
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :nodes_edges do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :source_id
      t.integer  :destination_id
    end
    add_index :nodes_edges, [:source_id]
    add_index :nodes_edges, [:destination_id]

    add_column :nodes, :parent_id, :integer
    add_column :nodes, :root_id, :integer

    add_index :nodes, [:parent_id]
    add_index :nodes, [:root_id]
  end

  def self.down
    remove_column :nodes, :parent_id
    remove_column :nodes, :root_id

    drop_table :libraries
    drop_table :nodes_edges

    remove_index :nodes, :name => :index_nodes_on_parent_id rescue ActiveRecord::StatementInvalid
    remove_index :nodes, :name => :index_nodes_on_root_id rescue ActiveRecord::StatementInvalid
  end
end
