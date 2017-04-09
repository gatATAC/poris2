class Label < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name :string
    timestamps
  end
  attr_accessible :name, :scope_kind, :scope_kind_id

  belongs_to :scope_kind, :inverse_of => :labels
  belongs_to :node, :creator => true, :inverse_of => :labels

  validates_presence_of :node, :scope_kind, :name

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
