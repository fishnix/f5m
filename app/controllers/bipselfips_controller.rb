class BipselfipsController < ApplicationController

  def index
    @bip_config = BipConfig.find(params[:bip_config_id])
    @bipselfip = @bip_config.bipselfips.all

    respond_to do |format|
      format.html # show.html.erb
    end
  end

end
