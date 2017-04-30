class NodeType < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name     :string
    totype   :string
    img_link :string
    timestamps
  end
  attr_accessible :name, :totype, :img_link

  # TODO: See if it is possible to ask for the fields
  def self.my_mandatory_attributes
    [:name, :totype, :img_link]
  end

  def self.my_attributes
    ret = my_mandatory_attributes
    return ret
  end

  validates_presence_of my_mandatory_attributes

  has_many :nodes, :inverse_of => :node_type, :accessible => :true

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
