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
  
  def update
    @bip_config = BipConfig.find(params[:bip_config_id])
    @bipclass = @bip_config.bipclasses.find(params[:id])

    if @bipclass.update_attributes(params[:bipclass])
      respond_to do |format|
        #format.html { redirect_to bip_config_bipclasses_path }
        #format.xml  { head :ok }
        format.html do
          if request.xhr?
            render :partial => "show", :locals => { :bip_class => @bipclass } , :layout => false, :status => :created
          else
            redirect_to bip_config_bipclasses_path
          end
        end
      end
    else
      respond_to do |format|
        format.html { render :action => "edit" }
        format.xml  { render :xml => @recipe.errors, :status => :unprocessable_entity }
      end
    end
  end
  
end
