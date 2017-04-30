class ValuesController < ApplicationController

  hobo_model_controller

  auto_actions :all, :except => :index

  def new
    hobo_new do
      if (params[:flow]) then
        sf = Flow.find(params[:flow])
        @this.flows << sf
        @this.project=sf.project
      end  
      @this.node_type = @this.default_node_type
      this.attributes = params[:mode] || {}
      hobo_ajax_response if request.xhr?
    end
  end

end
