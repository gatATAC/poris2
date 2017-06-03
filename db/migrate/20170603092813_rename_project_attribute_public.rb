class RenameProjectAttributePublic < ActiveRecord::Migration
  def self.up
    rename_column :projects, :public, :is_public
    change_column :projects, :is_public, :boolean, :default => :false
  end

  def self.down
    rename_column :projects, :is_public, :public
    change_column :projects, :public, :boolean
  end
end
