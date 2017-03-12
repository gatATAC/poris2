class AddNodesAndNodeTypes < ActiveRecord::Migration
  def self.up
    create_table :node_types do |t|
      t.string   :name
      t.string   :totype
      t.string   :img_link
      t.datetime :created_at
      t.datetime :updated_at
    end

    NodeType.create :name => "Library", :totype => "Library", :img_link => "/images/nodes/library.png"
    NodeType.create :name => "System", :totype => "SubSystem", :img_link => "/images/nodes/system.png"
    NodeType.create :name => "SubSystem", :totype => "SubSystem", :img_link => "/images/nodes/subsystem.png"
    NodeType.create :name => "Parameter", :totype => "SubSystem", :img_link => "/images/nodes/param.png"
    NodeType.create :name => "Value", :totype => "Value", :img_link => "/images/nodes/value.png"
    NodeType.create :name => "Mode", :totype => "Mode", :img_link => "/images/nodes/mode.png"
    NodeType.create :name => "Group", :totype => "Group", :img_link => "/images/nodes/system2.png"
    NodeType.create :name => "Accumulator", :totype => "Accumulator", :img_link => "/images/nodes/system2.png"
    NodeType.create :name => "Node", :totype => "Node", :img_link => "/images/nodes/system2.png"
    NodeType.create :name => "AlternateMode", :totype => "Mode", :img_link => "/images/nodes/mode.png"

    create_table :nodes do |t|
      t.string   :name
      t.integer  :type
      t.float    :rangemin
      t.float    :rangemax
      t.float    :default_float
      t.string   :default_string
      t.datetime :date_min
      t.datetime :date_max
      t.datetime :default_date
      t.string   :file_extension
      t.string   :file_description
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :project_id
      t.integer  :node_type_id
    end
    add_index :nodes, [:project_id]
    add_index :nodes, [:node_type_id]
  end

  def self.down
    drop_table :node_types
    drop_table :nodes
  end
end
