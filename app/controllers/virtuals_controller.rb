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

    respond_to do |format|
      if @virtual.update_attributes(params[:virtual])
        format.html { redirect_to bip_config_virtuals_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @recipe.errors, :status => :unprocessable_entity }
      end
    end
  end
  
end
