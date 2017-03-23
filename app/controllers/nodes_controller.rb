class NodesController < ApplicationController

  hobo_model_controller

  auto_actions :all, :except => [:index]
  auto_actions_for :project, [:new, :create]

  def new
    hobo_new do
      if (params[:super_node]) then
        sm = Node.find(params[:super_node])
        @this.sources << sm
        @this.project=sm.project
      end
      this.attributes = params[:node] || {}
      hobo_ajax_response if request.xhr?
    end
  end
end
