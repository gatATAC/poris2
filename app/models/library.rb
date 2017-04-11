class Library < Node
  has_many :sub_libs, :through => :edges_as_source, :accessible => true, :source => :destination, :class_name => 'Library'
  has_many :super_libs, :through => :edges_as_destination, :accessible => true, :source => :source, :class_name => 'Library'
  has_many :systems, :through => :edges_as_source, :accessible => true, :source => :destination, :class_name => 'System'

  attr_accessible :name, :node_type, :node_type_id, :project, :project_id, :super_libs, :sub_libs

  validates_presence_of my_mandatory_attributes

  children :sub_libs, :super_libs, :systems,:labels
  
  def full_name
    if super_libs.first then
      ret = super_libs.first.full_name + "_" + self.name
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