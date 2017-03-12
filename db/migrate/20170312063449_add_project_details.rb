class AddProjectDetails < ActiveRecord::Migration
  def self.up
    add_column :projects, :prefix, :string
    add_column :projects, :description, :text
    add_column :projects, :public, :boolean
  end

  def self.down
    remove_column :projects, :prefix
    remove_column :projects, :description
    remove_column :projects, :public
  end
end
