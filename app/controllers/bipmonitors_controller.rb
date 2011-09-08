class BipmonitorsController < ApplicationController
  def index
    @bip_config = BipConfig.find(params[:bip_config_id])
    @bipmonitors = @bip_config.bipmonitors.all

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def show
  end

end
