class Node < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name :string
    type         :integer
    rangemin :float
    rangemax :float
    default_float :float
    default_string :string
    date_min :datetime
    date_max :datetime
    default_date :datetime
    file_extension :string
    file_description :string

    timestamps
  end
  attr_accessible :name, :node_type, :node_type_id

  belongs_to :project, :creator => true, :inverse_of => :nodes
  belongs_to :node_type, :inverse_of => :nodes

  def self.my_mandatory_attributes
    [:name,:project_id,:node_type_id,:type]
  end

  def self.my_attributes
    ret=my_mandatory_attributes
    return ret
  end

  validates_presence_of my_mandatory_attributes

  # --- Permissions --- #

  def create_permitted?
    acting_user.signed_up? && project.accepts_changes_from?(acting_user)
  end

  def update_permitted?
    acting_user.signed_up? && project.accepts_changes_from?(acting_user)
  end

  def destroy_permitted?
    acting_user.signed_up? && project.accepts_changes_from?(acting_user)
  end

  def view_permitted?(attribute)
    acting_user.signed_up? && project.viewable_by?(acting_user)
  end

end
