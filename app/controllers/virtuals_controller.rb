class VirtualsController < ApplicationController

  def index
    @bip_config = BipConfig.find(params[:bip_config_id])
    @bipvirtuals = @bip_config.virtuals.all

    respond_to do |format|
      format.html # show.html.erb
    end
  end

end
