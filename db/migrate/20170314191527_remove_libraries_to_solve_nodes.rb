class RemoveLibrariesToSolveNodes < ActiveRecord::Migration
  def self.up
    remove_column :nodes, :type
    remove_column :nodes, :parent_id
    remove_column :nodes, :root_id

    remove_index :nodes, :name => :index_nodes_on_type rescue ActiveRecord::StatementInvalid
    remove_index :nodes, :name => :index_nodes_on_root_id rescue ActiveRecord::StatementInvalid
    remove_index :nodes, :name => :index_nodes_on_parent_id rescue ActiveRecord::StatementInvalid
  end

  def self.down
    add_column :nodes, :type, :string
    add_column :nodes, :parent_id, :integer
    add_column :nodes, :root_id, :integer

    add_index :nodes, [:type]
    add_index :nodes, [:root_id]
    add_index :nodes, [:parent_id]
  end
end
