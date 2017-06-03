class Mode < Node

  has_many :sub_modes, :through => :edges_as_source, :accessible => true, :source => :destination, 
  :class_name => 'Mode', :inverse_of => :super_modes
  has_many :super_modes, :through => :edges_as_destination, :accessible => true, :source => :source, 
  :class_name => 'Mode', :inverse_of => :sub_modes
  has_many :systems, :through => :edges_as_destination, :accessible => true, :source => :source, 
  :class_name => 'System', :inverse_of => :modes

  attr_accessible :name, :node_type, :node_type_id, :project, :project_id, :super_modes, 
    :sub_modes, :systems

  validates_presence_of my_mandatory_attributes

  children :sub_modes, :super_modes, :systems,:labels, :node_attributes
  
  def full_name
    sm = systems.first
    if sm then
      ret = sm.full_name + "_" + self.name
    else
      ret = self.name
    end
    return ret
  end

  def to_s
    full_name
  end

  def self.my_mandatory_attributes
    ret=super
  end

  def self.my_attributes
    ret=super
    ret+=[:default_mode_id]
  end

  def possible_sub_modes
    ret = []
    ret +=  self.project.modes - [self] - self.ancestors
  end

  def possible_super_modes
    ret = []
    ret += self.project.modes - [self] - self.descendants
  end


  def possible_systems
    ret = []
    ret += self.project.systems - self.systems
  end  

end
