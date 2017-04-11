class Project < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name         :string
    abbrev       :string
    hostnameport :string
    prefix :string
    description :text
    public :boolean    
    nodes_count :integer, :default => 0, :null => false
    timestamps
  end
  attr_accessible :name, :abbrev, :hostnameport, :owner_id, :owner, :prefix, :description, :public, :libraries, :nodes

  belongs_to :owner, :class_name => "User", :creator => true, :inverse_of => :projects

  # TODO: See if it is possible to ask for the fields
  def self.my_mandatory_attributes
    [:name, :abbrev, :hostnameport, :description, :prefix, :public]
  end

  def self.my_attributes
    ret = my_mandatory_attributes
    return ret
  end

  validates_presence_of my_mandatory_attributes

  has_many :project_memberships, :dependent => :destroy, :inverse_of => :project
  has_many :members, :through => :project_memberships, :source => :user
  has_many :contributor_memberships, :class_name => "ProjectMembership", :scope => :contributor
  has_many :contributors, :through => :contributor_memberships, :source => :user
  
  has_many :nodes, -> { order(position: :asc) }, :dependent => :destroy, :inverse_of => :project
  has_many :libraries, :dependent => :destroy, :inverse_of => :project

  children :project_memberships, :libraries

  # --- Permissions --- #

    # permission helper
  def accepts_changes_from?(user)
    user.administrator? || (owner_is? user) || user.in?(contributors)
  end

  def create_permitted?
    acting_user.administrator? || (owner_is? acting_user)
  end

  def update_permitted?
    accepts_changes_from?(acting_user) && !owner_changed?
  end

  def destroy_permitted?
    (acting_user.administrator? || owner_is?(acting_user))
  end

  def view_permitted?(field)
    (acting_user.administrator? || ((owner_is? acting_user))|| acting_user.in?(members) || self.public)
  end

end
