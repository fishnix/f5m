class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # Pull self ips from bigIP config
  # returns Hash
  def parse_selfips(confdata)
    regex = /^self\s+(\d+.\d+.\d+.\d+)\s+\{(.*?)\}/m
   
    selfips = Hash.new
    confdata.scan(regex) do |m|
      
      name = m[0]
      content = m[1]
      
      logger.debug "DEBUG selfips: " + name.to_s
      
      c = Hash.new
      c[:full] = content
      logger.debug "DEBUG selfips full " + c[:full].to_s
      
      c[:netmask] = content[/netmask\s+(\d+.\d+.\d+.\d+)\s*$/,1] ? content[/netmask\s+(\d+.\d+.\d+.\d+)\s*$/,1].chomp : nil
      logger.debug "DEBUG selfips netmask " + c[:netmask].to_s
      
      c[:unit] = content[/unit\s(\d+)\s*$/,1] ? content[/unit\s(\d+)\s*$/,1].chomp : nil
      logger.debug  "DEBUG selfips unit " + c[:unit].to_s
      
      c[:vlan] = content[/vlan\s+([A-Za-z0-9_-]+)\s*$/,1] ? content[/vlan\s+([A-Za-z0-9_-]+)\s*$/,1].chomp : nil
      logger.debug "DEBUG selfips vlan " + c[:vlan].to_s
      
      c[:floating] = content =~ /floating\s+enable\s*$/ ? true : false
      logger.debug "DEBUG selfips floating? " + c[:floating].to_s
      
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

      logger.debug "DEBUG virtuals: " + name.to_s
      
      c = Hash.new
      
      c[:full] = content
      logger.debug "DEBUG virtuals full " + c[:full].to_s
      
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
      logger.debug "DEBUG POOL full content: " + c[:full]
      
      c[:lb_method] = content[/lb\s+method\s+(.+)$/,1] ? content[/lb\s+method\s+(.+)$/,1].chomp : nil
      logger.debug "DEBUG POOL pool lb method " + c[:lb_method].to_s
      
      c[:members] = Array.new
      members = content.scan(/(\d+\.\d+\.\d+\.\d+:(?:\w+|\d+))/)
      
      members.each do |m|
        c[:members].push(m[0])
        logger.debug "DEBUG POOL members " + m[0] 
      end
      
      c[:monitors] = content.match(/monitor\s+all\s+([A-Za-z0-9_-]+)(?:\s+and\s+([A-Za-z0-9_-]+))*/).to_a
      c[:monitors].delete_at(0)
      c[:monitors].delete_if { |m| m.nil? }
      c[:monitors].each { |m| logger.debug "DEBUG POOL monitors " + m.to_s } unless c[:monitors].nil?
      
      pools[name] = c
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
      logger.debug "DEBUG nodes full " + c[:full].to_s

      c[:dyn_ratio] = content[/dynamic\s+ratio\s+(\d+)$/,1] ? content[/dynamic\s+ratio\s+(\d+)$/,1].chomp : nil
      logger.debug "DEBUG node dynamic ratio " + c[:dyn_ratio].to_s

      c[:limit] = content[/limit\s+(\d+)$/,1] ? content[/limit\s+(\d+)$/,1].chomp : nil
      logger.debug "DEBUG node limit " + c[:limit].to_s

      c[:ratio] = content[/^\s*ratio\s+(\d+)$/,1] ? content[/^\s*ratio\s+(\d+)$/,1].chomp : nil
      logger.debug "DEBUG node ratio " + c[:ratio].to_s
      
      c[:monitor] = content[/monitor\s+(.*)$/,1] ? content[/monitor\s+(.*)$/,1].chomp : nil
      logger.debug "DEBUG monitor " + c[:monitor].to_s

      c[:screen] = content[/screen\s+(.*)$/,1] ? content[/screen\s+(.*)$/,1].chomp : nil
      logger.debug "DEBUG screen " + c[:screen].to_s

      c[:updown] = content =~ /\s*down\s*$/ ? false : true
      logger.debug "DEBUG updown " + c[:updown].to_s
      
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
