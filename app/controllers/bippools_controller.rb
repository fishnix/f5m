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

  def update
    @bip_config = BipConfig.find(params[:bip_config_id])
    @bippool = @bip_config.bippools.find(params[:id])

    respond_to do |format|
      if @bippool.update_attributes(params[:bippool])
        format.html { redirect_to bip_config_bippools_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @recipe.errors, :status => :unprocessable_entity }
      end
    end
  end
  
end
