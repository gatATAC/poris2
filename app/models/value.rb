class Value < Node

  has_many :flows, :through => :edges_as_destination, :accessible => true, :source => :source, 
  :class_name => 'Flow', :inverse_of => :values

  attr_accessible :name, :node_type, :node_type_id, :project, :project_id, :flows

  validates_presence_of my_mandatory_attributes

  children :labels, :node_attributes
  
  def full_name
    if flows.first then
      ret = flows.first.full_name + "_" + self.name
    else
      ret = self.name
    end
    return ret
  end

  def self.my_mandatory_attributes
    ret=super
  end

  def self.my_attributes
    ret=super
    ret+=[:default_mode_id]
  end

end
