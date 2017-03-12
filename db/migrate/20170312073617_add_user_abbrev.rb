class AddUserAbbrev < ActiveRecord::Migration
  def self.up
    add_column :users, :abbrev, :string
  end

  def self.down
    remove_column :users, :abbrev
  end
end
