class DropNodesEdgeName < ActiveRecord::Migration
  def self.up
    add_column :nodes, :type, :string

    remove_column :nodes_edges, :name

    add_index :nodes, [:type]
  end

  def self.down
    remove_column :nodes, :type

    add_column :nodes_edges, :name, :string

    remove_index :nodes, :name => :index_nodes_on_type rescue ActiveRecord::StatementInvalid
  end
end
