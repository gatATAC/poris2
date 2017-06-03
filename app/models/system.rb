class System < Node
  has_many :sub_systems, :through => :edges_as_source, :accessible => true, :source => :destination, 
  :class_name => 'System', :inverse_of => :super_systems
  has_many :super_systems, :through => :edges_as_destination, :accessible => true, :source => :source, 
  :class_name => 'System', :inverse_of => :sub_systems
  has_many :libraries, :through => :edges_as_destination, :accessible => true, :source => :source, 
  :class_name => 'Library', :inverse_of => :systems
  has_many :flows, :through => :edges_as_source, :accessible => true, :source => :destination,
   :class_name => 'Flow', :inverse_of => :systems
  has_many :modes, :through => :edges_as_source, :accessible => true, :source => :destination,
   :class_name => 'Mode', :inverse_of => :systems

  attr_accessible :name, :node_type, :node_type_id, :project, :project_id, :super_systems, :sub_systems, :libraries, :flows, :modes

  validates_presence_of my_mandatory_attributes

  children :sub_systems, :super_systems, :libraries,:labels, :flows, :modes
  
  def full_name
    ss = super_systems.first
    if ss then
      ret = ss.full_name + "_" + self.name
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

  def possible_sub_systems
    ret = []
    ret +=  self.project.systems - [self] - self.ancestors
  end

  def possible_super_systems
    ret = []
    ret += self.project.systems - [self] - self.descendants
  end


  def possible_libraries
    ret = []
    ret += self.project.libraries - self.libraries
  end

  def possible_flows
    ret = []
    ret += self.project.flows - self.flows
  end

end