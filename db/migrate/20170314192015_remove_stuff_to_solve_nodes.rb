class RemoveStuffToSolveNodes < ActiveRecord::Migration
  def self.up
    remove_column :nodes, :rangemin
    remove_column :nodes, :rangemax
    remove_column :nodes, :default_float
    remove_column :nodes, :default_string
    remove_column :nodes, :date_min
    remove_column :nodes, :date_max
    remove_column :nodes, :default_date
    remove_column :nodes, :file_extension
    remove_column :nodes, :file_description

    add_column :nodes_edges, :name, :string
  end

  def self.down
    add_column :nodes, :rangemin, :float
    add_column :nodes, :rangemax, :float
    add_column :nodes, :default_float, :float
    add_column :nodes, :default_string, :string
    add_column :nodes, :date_min, :datetime
    add_column :nodes, :date_max, :datetime
    add_column :nodes, :default_date, :datetime
    add_column :nodes, :file_extension, :string
    add_column :nodes, :file_description, :string


    remove_column :nodes_edges, :name
  end
end
