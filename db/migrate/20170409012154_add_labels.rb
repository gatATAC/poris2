class AddLabels < ActiveRecord::Migration
  def self.up
    create_table :labels do |t|
      t.string   :name
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :scope_kind_id
      t.integer  :node_id
    end
    add_index :labels, [:scope_kind_id]
    add_index :labels, [:node_id]
  end

  def self.down
    drop_table :labels
  end
end
