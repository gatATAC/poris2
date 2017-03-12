class ProjectsController < ApplicationController

  hobo_model_controller

  auto_actions :show, :edit, :update, :destroy
  auto_actions_for :owner, [:new, :create]

  def show
    @project = find_instance
    @project_memberships = @project.project_memberships
    respond_to do |format|
    	format.html {
    		hobo_show
    	}
    end
  end

end