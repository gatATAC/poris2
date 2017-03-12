class AddProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string   :name
      t.string   :abbrev
      t.string   :hostnameport
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :projects
  end
end
