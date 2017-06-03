class ModesController < ApplicationController

  hobo_model_controller

  auto_actions :all, :except => :index

  def new
    hobo_new do
      if (params[:super_mode]) then
        sf = Mode.find(params[:super_mode])
        @this.super_modes << sf
        @this.project=sf.project
      end  
      if (params[:system]) then
        sys = System.find(params[:system])
        @this.systems << sys
        @this.project=sys.project
      end
      @this.node_type = @this.default_node_type
      this.attributes = params[:mode] || {}
      hobo_ajax_response if request.xhr?
    end
  end

end
