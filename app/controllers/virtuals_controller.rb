class VirtualsController < ApplicationController

  def index
    @bip_config = BipConfig.find(params[:bip_config_id])
    @bipvirtuals = @bip_config.virtuals.all
    
    @contacts = Contact.all
    
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def show
    @bip_config = BipConfig.find(params[:bip_config_id])
    @bipvirtual = @bip_config.virtuals.find(params[:id])
  end

  def update
    @bip_config = BipConfig.find(params[:bip_config_id])
    @virtual = @bip_config.virtuals.find(params[:id])
    @virtual.update_attributes(params[:virtual])
    redirect_to bip_config_virtuals_path
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
