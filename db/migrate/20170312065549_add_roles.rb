class AddRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string   :name
      t.string   :abbrev
      t.text     :description
      t.datetime :created_at
      t.datetime :updated_at
    end

    add_column :project_memberships, :role_id, :integer

    add_index :project_memberships, [:role_id]

    Role.create :name=>"Manager", :abbrev => "mng", :description => "Manager of the project.  Can alter the project team."
    Role.create :name=>"Project Scientist", :abbrev => "sci", :description => "Project Scientist."
    Role.create :name=>"Systems Engineer", :abbrev => "sys", :description => "Systems engineer of the project."
    Role.create :name=>"Optical Engineer", :abbrev => "opt", :description => "Optics engineer of the project."
    Role.create :name=>"Mechanics Engineer", :abbrev => "mech", :description => "Mechanics engineer of the project."
    Role.create :name=>"Hardware Engineer", :abbrev => "hw", :description => "Hardware engineer of the project."
    Role.create :name=>"Software Engineer", :abbrev => "sw", :description => "Software engineer of the project."

  end

  def self.down
    remove_column :project_memberships, :role_id

    drop_table :roles

    remove_index :project_memberships, :name => :index_project_memberships_on_role_id rescue ActiveRecord::StatementInvalid
  end
end
