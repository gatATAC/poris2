class NodesEdge < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    timestamps
  end

  attr_accessible :source, :source_id, :destination, :destination_id

  belongs_to :source, :class_name => 'Node', :creator => :true, :inverse_of => :edges_as_source
  belongs_to :destination, :class_name => 'Node', :inverse_of => :edges_as_destination

  acts_as_list :scope => :source
  
  # --- Permissions --- #

  def create_permitted?
    #acting_user.signed_up?
        true
  end

  def update_permitted?
    #acting_user.signed_up?
        true
  end

  def destroy_permitted?
    #acting_user.signed_up?
        true
  end

  def view_permitted?(field)
    true
  end

end
