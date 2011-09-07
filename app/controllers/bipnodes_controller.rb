class BipnodesController < ApplicationController
  
  def index
    @bip_config = BipConfig.find(params[:bip_config_id])
    @bipnodes = @bip_config.bipnodes.all

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def show
  end

end
