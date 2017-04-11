class System < Node
  has_many :sub_systems, :through => :edges_as_source, :accessible => true, :source => :destination, :class_name => 'System'
  has_many :super_systems, :through => :edges_as_destination, :accessible => true, :source => :source, :class_name => 'System'
  has_many :libraries, :through => :edges_as_destination, :accessible => true, :source => :source, :class_name => 'Library'

  attr_accessible :name, :node_type, :node_type_id, :project, :project_id, :super_systems, :sub_systems, :libraries

  validates_presence_of my_mandatory_attributes

  children :sub_systems, :super_systems, :libraries,:labels
  
  def full_name
    if super_systems.first then
      ret = super_systems.first.full_name + "_" + self.name
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