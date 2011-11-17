class BiprulesController < ApplicationController

  def index
    @bip_config = BipConfig.find(params[:bip_config_id])
    @biprules = @bip_config.biprules.all

    @biprules.each do |m|
      m.content = m.content.nil? ? ['parse error'] : m.content.strip.split(/\n/)
    end

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def show
  end
  
  def update
    @bip_config = BipConfig.find(params[:bip_config_id])
    @biprule = @bip_config.biprules.find(params[:id])

    respond_to do |format|
      if @biprule.update_attributes(params[:biprule])
        format.html { redirect_to bip_config_biprules_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @recipe.errors, :status => :unprocessable_entity }
      end
    end
  end

end
