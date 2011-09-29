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
    
    @bipcount = Hash.new
    @bipcount[:virtuals]    = @bip_config.virtuals.count
    @bipcount[:bipselfips]  = @bip_config.bipselfips.count
    @bipcount[:bippools]    = @bip_config.bippools.count
    @bipcount[:bipmonitors] = @bip_config.bipmonitors.count
    @bipcount[:bipnodes]    = @bip_config.bipnodes.count
    @bipcount[:biprules]    = @bip_config.biprules.count
    @bipcount[:bipclasses]  = @bip_config.bipclasses.count
    
    
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

  def upload
    file_param = params[:upload][:file]
    filedata = file_param.read
    
    conf_name = params[:upload][:name]
      
    @data = BipConfig.create(:name => conf_name, :content => filedata)
    
    parse_selfips(filedata).each do |n,c|
      Bipselfip.create( :name => n, :content => c[:full], :bip_config_id => @data.id, 
                        :netmask => c[:netmask], :unit => c[:unit], :floating => c[:floating], :vlan => c[:vlan])
    end  
    
    parse_rules(filedata).each do |n,c|
      Biprule.create(:name => n, :content => c, :bip_config_id => @data.id)
    end
    
    parse_monitors(filedata).each do |n,c|
      Bipmonitor.create(:name => n, :content => c, :bip_config_id => @data.id)
    end
    
    parse_classes(filedata).each do |n,c|
      Bipclass.create(:name => n, :content => c, :bip_config_id => @data.id)
    end
    
    parse_nodes(filedata).each do |n,c|
      Bipnode.create( :name => n, :content => c[:full], :bip_config_id => @data.id, :dyn_ratio => c[:dyn_ratio], 
                      :limit => c[:limit], :monitor => c[:monitor], :ratio => c[:ratio], :screen => c[:screen], :updown => c[:updown])
    end
    
    parse_pools(filedata).each do |n,c|
      bippool = Bippool.create(:name => n, :content => c, :bip_config_id => @data.id,
                      :lbmethod => c[:lb_method], :members => c[:members].join(','), :monitors => c[:monitors].join(','))
                      
      c[:members].each do |m|        
        mem = m.split(':')
        node = Bipnode.find_or_create_by_name_and_bip_config_id(mem[0], @data.id)
        member = Bipmember.find_or_create_by_name_and_bip_config_id(:name => m, :bip_config_id => @data.id, :ip => mem[0],
                                                                    :port => mem[1], :bipnode_id => node.id, :bippool_id => bippool.id)

        logger.debug "DEBUG POOL Members from pool. node: " + mem[0] + ' port: ' + mem[1]
      end
    end

    parse_virtuals(filedata).each do |n,c|
      Virtual.create(:name => n, :content => c, :bip_config_id => @data.id)
    end
    
    redirect_to bip_configs_path
    #render :text => rules
    #render :text => "created #{@data.id}"
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
