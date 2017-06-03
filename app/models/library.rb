class Library < Node
  has_many :sub_libs, :through => :edges_as_source, :accessible => true, :source => :destination, :class_name => 'Library'
  has_many :super_libs, :through => :edges_as_destination, :accessible => true, :source => :source, :class_name => 'Library'
  has_many :systems, :through => :edges_as_source, :accessible => true, :source => :destination, :class_name => 'System'

  attr_accessible :name, :node_type, :node_type_id, :project, :project_id, :super_libs, :sub_libs

  validates_presence_of my_mandatory_attributes

  #children :sub_libs, :super_libs, :systems,:labels
  
  def full_name
    sl = super_libs.first
    if sl then
      ret = sl.full_name + "_" + self.name
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

  def ancestor_relation
    return super_libs
  end

  def descendant_relation
    return sub_libs
  end

  def possible_sub_libs
    ret = []
    ret +=  self.project.libraries - [self] - self.ancestors
  end

  def possible_super_libs
    ret = []
    ret += self.project.libraries - [self] - self.descendants
  end

end