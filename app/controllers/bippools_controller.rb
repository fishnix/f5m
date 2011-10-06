class BippoolsController < ApplicationController
  def index
    @bip_config = BipConfig.find(params[:bip_config_id])
    @bippools = @bip_config.bippools.all

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def show
    @bip_config = BipConfig.find(params[:bip_config_id])
    @bippool = @bip_config.bippools.find(params[:id])
    #@bipnodes = @bippool.bipnodes.all
  end

end
