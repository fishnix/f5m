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
  # returns Hash of:
  # - full content
  # - enable
  # - destination
  # - mask
  # - mirror
  # - limit
  # - ip protocol
  # - snat
  # - snatpool
  # - srcport
  # - type: ip forward | l2 forward | reject
  # - pool
  # - persist
  # - fb_persist
  #
  # Didnt handle:
  # - auth
  # - clone pools
  # - cmp
  # - cmp processor
  # - rate class
  # - translate address
  # - translate service
  def parse_virtuals(confdata)
    
    regex = /^virtual\s+([A-Za-z0-9_-]+)\s+\{(.*?)\}/m
   
    virtuals = Hash.new
    confdata.scan(regex) do |m|
      
      name = m[0]
      content = m[1]

      logger.debug "DEBUG VIRTUAL: " + name.to_s
      
      c = Hash.new
      
      c[:full] = content
      logger.debug "DEBUG VIRTUAL full: " + c[:full].strip.gsub(/\n/,',')
      
      # virtual enabled?
      c[:enable] = content[/^disable$/,1] ? false : true
      logger.debug "DEBUG VIRTUAL enabled: " + c[:enable].to_s
      
      # destination IP and port
      c[:destination] = content[/destination\s+(\d+\.\d+\.\d+\.\d+:(?:\d+|\w+))$/,1] ? content[/destination\s+(\d+\.\d+\.\d+\.\d+:(?:\d+|\w+))$/,1].chomp : nil
      logger.debug "DEBUG VIRTUAL destination: " + c[:destination] unless c[:destination].nil?
      
      # mask
      c[:mask] = content[/mask\s+(\d+\.\d+\.\d+\.\d+|none)$/,1] ? content[/mask\s+(\d+\.\d+\.\d+\.\d+|none)$/,1].chomp : nil
      logger.debug "DEBUG VIRTUAL mask: " + c[:mask] unless c[:mask].nil?
      
      # mirrored?
      c[:mirror] = content[/mirror\s+enable$/,1] ? true : false
      logger.debug "DEBUG VIRTUAL mirror: " + c[:mirror].to_s
      
      # limit
      c[:limit] = content[/limit\s+(\d+)/,1] ? content[/limit\s+(\d+)/,1].chomp : nil
      logger.debug "DEBUG VIRUTAL limit: " + c[:limit] unless c[:limit].nil?
      
      # ip protocol
      c[:ip_protocol] = content[/ip\sprotocol\s+([A-Za-z0-9_-]+)$/,1] ? content[/ip\sprotocol\s+([A-Za-z0-9_-]+)$/,1].chomp : nil
      logger.debug "DEBUG VIRTUAL ip protocol: " + c[:ip_protocol] unless c[:ip_protocol].nil?
      
      # snat autmap|none
      c[:snat] = content[/snat\s+(automap|none)$/,1] ? content[/snat\s+(automap|none)$/,1].chomp : nil
      logger.debug "DEBUG VIRTUAL snat: " + c[:snat] unless c[:snat].nil?
    
      # snatpool
      c[:snatpool] = content[/snatpool\s+([A-Za-z0-9_-]+)$/,1] ? content[/snatpool\s+([A-Za-z0-9_-]+)$/,1].chomp : nil
      logger.debug "DEBUG VIRTUAL pool: " + c[:snatpool] unless c[:snatpool].nil?    
      
      # srcport
      c[:srcport] = content[/srcport\s+(preserve|preserve\s+strict|change)$/,1] ? content[/srcport\s+(preserve|preserve\s+strict|change)$/,1].chomp : nil
      logger.debug "DEBUG VIRTUAL srcport: " + c[:srcport] unless c[:srcport].nil?
      
      # type
      c[:type] = String.new
      if content.match(/ip\s+forward/) then
        c[:type] = 'ip forward'
      elsif content.match(/l2\s+forward/) then
        c[:type] = 'l2 forward'
      elsif content.match(/\s*reject$/) then
        c[:type] = 'reject'
      else
        c[:type] = nil
      end
      logger.debug "DEBUG VIRTUAL type: " + c[:type] unless c[:type].nil?
      
      # default pool
      c[:pool] = content[/pool\s+([A-Za-z0-9_-]+)$/,1] ? content[/pool\s+([A-Za-z0-9_-]+)$/,1].chomp : nil
      logger.debug "DEBUG VIRTUAL pool: " + c[:pool] unless c[:pool].nil?
      
      # persistence 
      c[:persist] = content[/persist\s+([A-Za-z0-9_-]+)$/,1] ? content[/persist\s+([A-Za-z0-9_-]+)$/,1].chomp : nil
      logger.debug "DEBUG VIRTUAL persist: " + c[:persist] unless c[:persist].nil?
     
      # fallback persist
      c[:fb_persist] = content[/fallback\spersist\s+([A-Za-z0-9_-]+)$/,1] ? content[/fallback\spersist\s+([A-Za-z0-9_-]+)$/,1].chomp : nil
      logger.debug "DEBUG VIRTUAL fallback persist: " + c[:fb_persist] unless c[:fb_persist].nil?
      
      
      
      # Collect profiles 
      c[:profiles] = Array.new
      ins = 0
      kwregex = /^\s*(enable|disable|auth|clone\spools|cmp|destination|fallback\spersist|ip\sforward|l2\sforward|reject|ip\sprotocol|httpclass|lasthop|limit|mask|mirror|persist|pool|rate|rules|snat|snatpool|srcport|translate|vlan).*$/
      content.strip.each_line do |p|
        ins = 1 if p.match(/^\s*profiles/)
        ins = 0 if p.match(kwregex)
        
        if ins == 1
          p.strip!
          c[:profiles].push(p) unless p.match(/(profiles|clientside|serverside)/)
          logger.debug "DEBUG VIRTUAL profiles " + p unless p.to_s.nil? or p.match(/profiles|clientside|serverside/)
        end
        
      end
      
      # Collect rules 
      c[:rules] = Array.new
      ins = 0
      kwregex = /^\s*(enable|disable|auth|clone\spools|cmp|destination|fallback\spersist|ip\sforward|l2\sforward|reject|ip\sprotocol|httpclass|lasthop|limit|mask|mirror|persist|pool|profiles|rate|snat|snatpool|srcport|translate|vlan).*$/
      content.strip.each_line do |r|
        ins = 1 if r.match(/^\s*rules/)
        ins = 0 if r.match(kwregex)
        
        if ins == 1
          r.strip!.sub!(/^rules\s*/,'')
          c[:rules].push(r) unless r.nil? or r.empty?
          logger.debug "DEBUG VIRTUAL rules " + r unless r.nil? or r.empty?
        end
        
      end
      
      # Collect vlans 
      c[:vlans] = Array.new
      ins = 0
      kwregex = /^\s*(enable|disable|auth|clone\spools|cmp|destination|fallback\spersist|ip\sforward|l2\sforward|reject|ip\sprotocol|httpclass|lasthop|limit|mask|mirror|persist|pool|profiles|rate|rules|snat|snatpool|srcport|translate).*$/
      content.strip.each_line do |s|
        ins = 1 if s.match(/^\s*vlans/)
        ins = 0 if s.match(kwregex)
        
        if ins == 1
          s.strip!.sub!(/^vlans\s*/,'').sub!(/\s+enable\s*/,'')
          c[:vlans].push(s) unless s.nil? or s.empty?
          logger.debug "DEBUG VIRTUAL vlans " + s unless s.nil? or s.empty?
        end
        
      end
      
      # Collect httpclasses 
      c[:httpclasses] = Array.new
      ins = 0
      kwregex = /^\s*(enable|disable|auth|clone\spools|cmp|destination|fallback\spersist|ip\sforward|l2\sforward|reject|ip\sprotocol|lasthop|limit|mask|mirror|persist|pool|profiles|rate|rules|snat|snatpool|srcport|translate|vlan).*$/
      content.strip.each_line do |s|
        ins = 1 if s.match(/^\s*httpclass/)
        ins = 0 if s.match(kwregex)
        
        if ins == 1
          s.strip!.sub!(/^httpclass\s*/,'')
          c[:httpclasses].push(s) unless s.nil? or s.empty?
          logger.debug "DEBUG VIRTUAL rules " + s unless s.nil? or s.empty?
        end
        
      end
      
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
