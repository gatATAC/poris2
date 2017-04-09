class AddNodeAttributes < ActiveRecord::Migration
  def self.up
    create_table :node_attributes do |t|
      t.string   :name
      t.string   :content
      t.boolean  :visibility, :default => true
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :node_id
    end
    add_index :node_attributes, [:node_id]
  end

  def self.down
    drop_table :node_attributes
  end
end
