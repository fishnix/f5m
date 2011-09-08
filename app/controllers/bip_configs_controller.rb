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

  # POST /bip_configs
  # POST /bip_configs.xml
  #def create
  #  @bip_config = BipConfig.new(params[:bip_config])
  #  @bip_config[:content] = @bipconfig_filename
  #  
  #  respond_to do |format|
  #    if @bip_config.save
  #      format.html { redirect_to(@bip_config, :notice => 'Bip config was successfully created.') }
  #      format.xml  { render :xml => @bip_config, :status => :created, :location => @bip_config }
  #    else
  #      format.html { render :action => "new" }
  #      format.xml  { render :xml => @bip_config.errors, :status => :unprocessable_entity }
  #    end
  #  end
  #end

  def upload
    file_param = params[:upload][:file]
    filedata = file_param.read
    
    conf_name = params[:upload][:name]
      
    @data = BipConfig.create(:name => conf_name, :content => filedata)
    
    parse_virtuals(filedata).each do |n,c|
      Virtual.create(:name => n, :content => c, :bip_config_id => @data.id)
    end
    
    parse_pools(filedata).each do |n,c|
      Bippool.create(:name => n, :content => c, :bip_config_id => @data.id)
    end
    
    parse_selfips(filedata).each do |n,c|
      Bipselfip.create( :name => n, :content => c[:full], :bip_config_id => @data.id, 
                        :netmask => c[:netmask], :unit => c[:unit], :floating => c[:floating], :vlan => c[:vlan])
    end
    
    parse_nodes(filedata).each do |n,c|
      Bipnode.create( :name => n, :content => c[:full], :bip_config_id => @data.id, :dyn_ratio => c[:dyn_ratio], 
                      :limit => c[:limit], :monitor => c[:monitor], :ratio => c[:ratio], :screen => c[:screen], :updown => c[:updown])
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
  
  # Pull self ips from bigIP config
  # returns Hash
  def parse_selfips(confdata)
    regex = /^self\s+(\d+.\d+.\d+.\d+)\s+\{(.*?)\}/m
   
    selfips = Hash.new
    confdata.scan(regex) do |m|
      
      name = m[0]
      content = m[1]
      
      logger.debug "selfips: " + name.to_s
      
      c = Hash.new
      c[:full] = content
      logger.debug "selfips full " + c[:full].to_s
      
      c[:netmask] = content[/netmask\s+(\d+.\d+.\d+.\d+)\s*$/,1] ? content[/netmask\s+(\d+.\d+.\d+.\d+)\s*$/,1].chomp : nil
      logger.debug "selfips netmask " + c[:netmask].to_s
      
      c[:unit] = content[/unit\s(\d+)\s*$/,1] ? content[/unit\s(\d+)\s*$/,1].chomp : nil
      logger.debug  "selfips unit " + c[:unit].to_s
      
      c[:vlan] = content[/vlan\s+([A-Za-z0-9_-]+)\s*$/,1] ? content[/vlan\s+([A-Za-z0-9_-]+)\s*$/,1].chomp : nil
      logger.debug "selfips vlan " + c[:vlan].to_s
      
      c[:floating] = content =~ /floating\s+enable\s*$/ ? true : false
      logger.debug "selfips floating? " + c[:floating].to_s
      
      selfips[name] = c
    end
    
    selfips
  end

  # Pull virtuals from bigIP conf
  # returns Hash
  def parse_virtuals(confdata)
    
    regex = /^virtual\s+([A-Za-z0-9_-]+)\s+\{(.*?)\}/m
   
    virtuals = Hash.new
    confdata.scan(regex) do |m|
      
      name = m[0]
      content = m[1]

      logger.debug "virtuals: " + name.to_s
      
      c = Hash.new
      
      c[:full] = content
      logger.debug "virtuals full " + c[:full].to_s
      
      virtuals[name] = c[:full]
    end
    
    virtuals
  end
 
  # Pull pools from bigIP conf
  # returns Hash
  def parse_pools(confdata)
    regex = /^pool\s+([A-Za-z0-9_-]+)\s+\{(.*?)\}/m
   
    pools = Hash.new
    confdata.scan(regex) do |m|
      
      name = m[0]
      content = m[1]

      logger.debug "pools: " + name.to_s
      
      c = Hash.new
      
      c[:full] = content
      logger.debug "pools full " + c[:full].to_s
      
      c[:lb_method] = content[/lb\s+method\s+(.+)$/,1] ? content[/lb\s+method\s+(.+)$/,1].chomp : nil
      logger.debug "pool lb method " + c[:lb_method].to_s
      
      pools[name] = c[:full]
    end
    
    pools
  end 
  
  # Pull nodes from bigIP conf
  # returns Hash
  def parse_nodes(confdata)
    regex = /^node\s+(\d+.\d+.\d+.\d+)\s+\{(.*?)\}/m
   
    nodes = Hash.new
    confdata.scan(regex) do |m|

      name = m[0]
      content = m[1]

      logger.debug "virtuals: " + name.to_s

      c = Hash.new

      c[:full] = content
      logger.debug "nodes full " + c[:full].to_s

      c[:dyn_ratio] = content[/dynamic\s+ratio\s+(\d+)$/,1] ? content[/dynamic\s+ratio\s+(\d+)$/,1].chomp : nil
      logger.debug "node dynamic ratio " + c[:dyn_ratio].to_s

      c[:limit] = content[/limit\s+(\d+)$/,1] ? content[/limit\s+(\d+)$/,1].chomp : nil
      logger.debug "node limit " + c[:limit].to_s

      c[:ratio] = content[/^\s*ratio\s+(\d+)$/,1] ? content[/^\s*ratio\s+(\d+)$/,1].chomp : nil
      logger.debug "node ratio " + c[:ratio].to_s
      
      c[:monitor] = content[/monitor\s+(.*)$/,1] ? content[/monitor\s+(.*)$/,1].chomp : nil
      logger.debug "monitor " + c[:monitor].to_s

      c[:screen] = content[/screen\s+(.*)$/,1] ? content[/screen\s+(.*)$/,1].chomp : nil
      logger.debug "screen " + c[:screen].to_s

      c[:updown] = content =~ /\s*down\s*$/ ? false : true
      logger.debug "updown " + c[:updown].to_s
      
      nodes[name] = c
    end
    
    nodes
  end
  
  # Pull monitors from bigIP conf
  # returns Hash
  def parse_monitors(confdata)
    regex = /^monitor\s+([A-Za-z0-9_-]+)\s+\{(.*?)\}/m
   
    monitors = Hash.new
    confdata.scan(regex) do |m|
      monitors[m[0]] = m[1]
    end
    
    monitors
  end
  
  # Pull classes from bigIP conf
  # returns Hash
  def parse_classes(confdata)
    regex = /^class\s+([A-Za-z0-9_-]+)\s+\{(.*?)\}/m
   
    classes = Hash.new
    confdata.scan(regex) do |m|
      classes[m[0]] = m[1]
    end
    
    classes
  end
  
  # Pull rules from bigIP conf
  # returns Hash
  def parse_rules(confdata)
    regex = /^rule\s+([A-Za-z0-9_-]+)\s+\{/
   
    rules = Hash.new
    confdata.scan(regex) do |m|
      rules[m[0]] = nil
    end
    
    rules
  end
  
  
end
