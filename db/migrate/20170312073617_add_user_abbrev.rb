class AddUserAbbrev < ActiveRecord::Migration
  def self.up
    add_column :users, :abbrev, :string

    #TODO: Add an script to update users to have a default abbreviation
 #	User.all.each {|u|
#		u.abbrev = u.name 
#		u.save
#	}
  end

  def self.down
    remove_column :users, :abbrev
  end
end
