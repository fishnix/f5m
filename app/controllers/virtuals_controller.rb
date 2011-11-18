class VirtualsController < ApplicationController

  def index
    @bip_config = BipConfig.find(params[:bip_config_id])
    @bipvirtuals = @bip_config.virtuals.all

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def show
  end

  def update
    @bip_config = BipConfig.find(params[:bip_config_id])
    @virtual = @bip_config.virtuals.find(params[:id])
    @virtual.update_attributes(params[:virtual])
  end
  
  def migrate
    @bip_config = BipConfig.find(params[:bip_config_id])
    @virtual = @bip_config.virtuals.find(params[:virtual_id])
    @virtual.update_attributes(:migrated => true)
  end
  
  def unmigrate
    @bip_config = BipConfig.find(params[:bip_config_id])
    @virtual = @bip_config.virtuals.find(params[:virtual_id])
    @virtual.update_attributes(:migrated => false)
  end
  
end
