class BipmonitorsController < ApplicationController
  def index
    @bip_config = BipConfig.find(params[:bip_config_id])
    @bipmonitors = @bip_config.bipmonitors.all
    
    #@bipmonitors.each do |m|
    #  m.content = m.content.nil? ? ['monitorroot'] : m.content.strip.split(/\n/)
    #  #m.migrated = m.migrated.nil? ? false : m.migrated
    #end
    #<%= render :partial => "content", :locals => { :bip_monitor => bip_monitor } %>

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
    @bipmonitor.update_attributes(params[:bipmonitor])
  end
  
  def migrate
    @bip_config = BipConfig.find(params[:bip_config_id])
    @bipmonitor = @bip_config.bipmonitors.find(params[:bipmonitor_id])
    @bipmonitor.update_attributes(:migrated => true)
  end
  
  def unmigrate
    @bip_config = BipConfig.find(params[:bip_config_id])
    @bipmonitor = @bip_config.bipmonitors.find(params[:bipmonitor_id])
    @bipmonitor.update_attributes(:migrated => false)
  end

end
