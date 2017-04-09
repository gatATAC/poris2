class AddScopeKinds < ActiveRecord::Migration
  def self.up
    create_table :scope_kinds do |t|
      t.string   :name
      t.text     :description
      t.string   :src_format
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :scope_kinds
  end
end
