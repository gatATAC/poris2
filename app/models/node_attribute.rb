class NodeAttribute < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name       :string
    content    :string
    visibility :boolean, :default => true
    timestamps
  end
  attr_accessible :name, :content, :visibility, :node, :node_id

  belongs_to :node, :creator => true, :inverse_of => :node_attributes

  acts_as_list :scope => :node

  validates_presence_of :node, :name, :content

  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

  # --- Permissions --- #

  def create_permitted?
    acting_user.signed_up? && node.project.accepts_changes_from?(acting_user)
  end
  def update_permitted?
    acting_user.signed_up? && !node_changed? && node.project.accepts_changes_from?(acting_user)
  end

  def destroy_permitted?
    acting_user.signed_up? && node.project.accepts_changes_from?(acting_user)
  end

  def view_permitted?(attribute)
    node.viewable_by?(acting_user)
  end


end
