class ProjectsController < ApplicationController

  hobo_model_controller

  auto_actions :show, :edit, :update, :destroy
  auto_actions_for :owner, [:new, :create]

  def show
    @project = find_instance
    @nodes =
      @project.nodes
    pm = @project.project_memberships
    pm = pm.order_by(parse_sort_param(:name, :role))
    pm = pm.role_is(params[:role]) if params[:role] && !params[:role].blank?
    if params[:search] && !params[:search].blank?
      pm = pm.joins(:user).where('users.name like ?', "%"+params[:search]+"%")
    end
    @project_memberships = pm
    
    rl = @project.libraries
    rl = rl.order_by(parse_sort_param(:name))
    if params[:libsearch] && !params[:libsearch].blank?
      rl = rl.where('name like ?', "%"+params[:libsearch]+"%")
    end
    @libraries = rl

    hobo_show
  end

end
