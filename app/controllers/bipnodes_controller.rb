class BipnodesController < ApplicationController
  
  def index
    @bip_config = BipConfig.find(params[:bip_config_id])
    @bipnodes = @bip_config.bipnodes.all

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def show
    @bip_config = BipConfig.find(params[:bip_config_id])
    @bipnode = @bip_config.bipnodes.find(params[:id])
  end

  def update
    @bip_config = BipConfig.find(params[:bip_config_id])
    @bipnode = @bip_config.bipnodes.find(params[:id])

    respond_to do |format|
      if @bipnode.update_attributes(params[:bipnode])
        format.html { redirect_to bip_config_bipnodes_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @recipe.errors, :status => :unprocessable_entity }
      end
    end
  end
  
end
