class Role < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name :string, :unique
    abbrev :string, :unique
    description :text
    timestamps
  end
  attr_accessible :name, :abbrev, :description

  # TODO: See if it is possible to ask for the fields
  def self.my_mandatory_attributes
    [:name, :abbrev, :description]
  end

  def self.my_attributes
    ret = my_mandatory_attributes
    return ret
  end

  validates_presence_of my_mandatory_attributes
  has_many :project_memberships

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

end
