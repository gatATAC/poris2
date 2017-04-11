class AddNodeCounterCache < ActiveRecord::Migration
  def self.up
    add_column :projects, :nodes_count, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :projects, :nodes_count
  end
end
