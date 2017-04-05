class LibrariesAsList < ActiveRecord::Migration
  def self.up
    add_column :nodes, :position, :integer
  end

  def self.down
    remove_column :nodes, :position
  end
end
