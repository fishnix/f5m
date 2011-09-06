class BipConfigsController < ApplicationController
  # GET /bip_configs
  # GET /bip_configs.xml
  def index
    @bip_configs = BipConfig.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bip_configs }
    end
  end

  # GET /bip_configs/1
  # GET /bip_configs/1.xml
  def show
    @bip_config = BipConfig.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bip_config }
    end
  end

  # GET /bip_configs/new
  # GET /bip_configs/new.xml
  def new
    @bip_config = BipConfig.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bip_config }
    end
  end

  # POST /bip_configs
  # POST /bip_configs.xml
  def create
    @bip_config = BipConfig.new(params[:bip_config])
    @bip_config[:content] = @bipconfig_filename
    
    respond_to do |format|
      if @bip_config.save
        format.html { redirect_to(@bip_config, :notice => 'Bip config was successfully created.') }
        format.xml  { render :xml => @bip_config, :status => :created, :location => @bip_config }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bip_config.errors, :status => :unprocessable_entity }
      end
    end
  end

  def upload
    file_param = params[:upload][:file]
    conf_name = params[:upload][:name]
    filename = file_param.original_filename
    filedata = file_param.read
    
    @data = BipConfig.create(:name => filename, :content => filedata)
    
    render :text => "created #{@data.id}"
  end

  # DELETE /bip_configs/1
  # DELETE /bip_configs/1.xml
  def destroy
    @bip_config = BipConfig.find(params[:id])
    @bip_config.destroy

    respond_to do |format|
      format.html { redirect_to(bip_configs_url) }
      format.xml  { head :ok }
    end
  end
end
