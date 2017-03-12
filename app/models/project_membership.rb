class ProjectMembership < ActiveRecord::Base


  hobo_model # Don't put anything above this

  fields do
    contributor :boolean, :default => false
    maximum_layer :integer, :default => 0
    timestamps
  end

  attr_accessible :contributor, :maximum_layer, :user, :user_id, :role, :role_id

  belongs_to :project, :inverse_of => :project_memberships
  belongs_to :user, :inverse_of => :project_memberships
  belongs_to :role, :inverse_of => :project_memberships

  # TODO: See if it is possible to ask for the fields
  def self.my_mandatory_attributes
    [:project, :user, :maximum_layer, :role]
  end

  def self.my_attributes
    ret = my_mandatory_attributes
    return ret
  end

  validates_presence_of my_mandatory_attributes

def name
  ret = ""
  ret += user.abbrev
  ret += " as "
  ret += role.abbrev
  ret += " in "
  ret += project.abbrev
end

  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator? || acting_user == project.owner
  end

  def update_permitted?
    (acting_user.administrator? || acting_user == project.owner) && !project_changed?
  end

  def destroy_permitted?
    acting_user.administrator? || acting_user == project.owner
  end

  def view_permitted?(attribute)
    project.viewable_by?(acting_user)
  end
end
