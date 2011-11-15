class BipclassesController < ApplicationController
  def index
    @bip_config = BipConfig.find(params[:bip_config_id])
    @bipclasses = @bip_config.bipclasses.all

    @bipclasses.each do |c|
      c.content = c.content.nil? ? ['parse error'] : c.content.strip.split(/\n/)
    end

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def show
      @bip_config = BipConfig.find(params[:bip_config_id])
      @bipclass = @bip_config.bipclasses.find(params[:id])
      
      respond_to do |format|
        format.html # show.html.erb
      end
  end
  
  def migrate
    @bip_config = BipConfig.find(params[:bip_config_id])
    @bipclass = @bip_config.bipclasses.find(params[:id])
    @bipclass.update_attribute(:migrated, true)
  end

end
