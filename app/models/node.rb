class Node < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name :string
    timestamps
  end

  attr_accessible :name, :node_type, :node_type_id, :project, 
  :project_id, :edges_as_source, :destinations, :edges_as_destination, 
  :sources, :position, :tree_order, :parent, :parent_id, :node_attributes

  belongs_to :project, :creator => true, :inverse_of => :nodes, :counter_cache => true, :accessible => :true
  belongs_to :node_type, :inverse_of => :nodes, :accessible => :true

  acts_as_list :scope => :project

  has_many :edges_as_source, -> { order(position: :asc) }, :class_name => 'NodesEdge', :foreign_key => 'source_id', :dependent => :destroy, :inverse_of => :source
  has_many :destinations, :through => :edges_as_source, :class_name => 'Node', :inverse_of => :sources
  has_many :edges_as_destination, :class_name => 'NodesEdge', :foreign_key => 'destination_id', :inverse_of => :destination, :dependent => :destroy
  has_many :sources, :through => :edges_as_destination, :class_name => 'Node', :inverse_of => :destinations

  has_many :node_attributes, :dependent => :destroy, :inverse_of => :node
  has_many :labels, :dependent => :destroy, :inverse_of => :node

  def self.my_mandatory_attributes
    [:name,:project_id,:node_type_id]
  end

  def self.my_attributes
    ret=my_mandatory_attributes
    return ret
  end
 
  validates_presence_of my_mandatory_attributes
  validate :destinations_valid?

  children :destinations, :sources


  def possible_destinations
    ret = []
    ret += self.project.nodes - [self] - self.sources
  end

  def possible_sources
    ret = []
    ret += self.project.nodes - [self] - self.destinations
  end

  def destinations_valid?
    if ((possible_destinations & destinations) == destinations) then
      aux = destinations & sources
      if (not(aux.empty?)) then
        errors.add(:destinations, "can't contain a node already present in sources")
      end
    else
        errors.add(:destinations, "can't contain a node not suitable for present node. f.i. not of the same project.")
    end
  end

  def default_node_type
    NodeType.find_by_name(self.class.name)
  end

  def ancestor_relation
    return sources
  end

  def descendant_relation
    return destinations
  end
  
  def ancestors
    ret = []
    sources.each { |e|
      ret += [e]
      ret += e.ancestors
    }
    return ret
  end

  def descendants
    ret = []
    sources.each { |e|
      ret += [e]
      ret += e.descendants
    }
    return ret
  end

  # --- Permissions --- #

  def create_permitted?
    acting_user.signed_up? && ((project == nil) || project.accepts_changes_from?(acting_user))
  end

  def update_permitted?
    acting_user.signed_up? && project.accepts_changes_from?(acting_user) 
    # && !node_type_changed?
  end

  def destroy_permitted?
    acting_user.signed_up? && project.accepts_changes_from?(acting_user)
  end

  def view_permitted?(attribute)
    acting_user.signed_up? && ((project == nil) || project.viewable_by?(acting_user))
  end

end
