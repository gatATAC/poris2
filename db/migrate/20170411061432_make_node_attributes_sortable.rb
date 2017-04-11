class MakeNodeAttributesSortable < ActiveRecord::Migration
  def self.up
    add_column :node_attributes, :position, :integer
  end

  def self.down
    remove_column :node_attributes, :position
  end
end
