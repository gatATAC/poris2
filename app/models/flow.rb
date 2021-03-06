class Flow < System

  has_many :sub_flows, :through => :edges_as_source, :accessible => true, :source => :destination, 
  :class_name => 'Flow', :inverse_of => :super_flows
  has_many :super_flows, :through => :edges_as_destination, :accessible => true, :source => :source, 
  :class_name => 'Flow', :inverse_of => :sub_flows
  has_many :systems, :through => :edges_as_destination, :accessible => true, :source => :source, 
  :class_name => 'System', :inverse_of => :flows
  has_many :values, :through => :edges_as_source, :accessible => true, :source => :destination, 
  :class_name => 'Value', :inverse_of => :flows

  attr_accessible :name, :node_type, :node_type_id, :project, :project_id, :super_flows, 
    :sub_flows, :systems, :values

  validates_presence_of my_mandatory_attributes

  children :sub_flows, :super_flows, :systems,:labels, :node_attributes, :values
  
  def full_name
    sf = self.super_flows.first
    if sf then
      ret = sf.full_name + "_" + self.name
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


  def possible_sub_flows
    ret = []
    ret +=  self.project.flows - [self] - self.ancestors
  end

  def possible_super_flows
    ret = []
    ret += self.project.flows - [self] - self.descendants
  end


  def possible_systems
    ret = []
    ret += self.project.systems - self.systems
  end

  def possible_values
    ret = []
    ret += self.project.values - self.values
  end


end
