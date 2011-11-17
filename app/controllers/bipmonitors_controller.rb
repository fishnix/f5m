class BipmonitorsController < ApplicationController
  def index
    @bip_config = BipConfig.find(params[:bip_config_id])
    @bipmonitors = @bip_config.bipmonitors.all
    
    @bipmonitors.each do |m|
      m.content = m.content.nil? ? ['monitorroot'] : m.content.strip.split(/\n/)
      #m.migrated = m.migrated.nil? ? false : m.migrated
    end

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def show
    @bip_config = BipConfig.find(params[:bip_config_id])
    @bipmonitor = @bip_config.bipmonitors.find(params[:id])
    @bipmon = @bipmonitor.content.nil? ? ['monitorroot'] : @bipmonitor.content.strip.split(/\n/)
  end
  
  def update
    @bip_config = BipConfig.find(params[:bip_config_id])
    @bipmonitor = @bip_config.bipmonitors.find(params[:id])

    respond_to do |format|
      if @bipmonitor.update_attributes(params[:bipmonitor])
        format.html { redirect_to bip_config_bipmonitors_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @recipe.errors, :status => :unprocessable_entity }
      end
    end
  end

end
