class BipprofilesController < ApplicationController
  def index
    @bip_config = BipConfig.find(params[:bip_config_id])
    @bipprofiles = @bip_config.bipprofiles.all

    #@bipprofiles.each do |m|
    #  m.content = m.content.nil? ? ['parse error'] : m.content.strip.split(/\n/)
    #end
    #<td><%= render :partial => "content", :locals => { :bip_profile => bip_profile } %></td>

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def show
    @bip_config = BipConfig.find(params[:bip_config_id])
    @bipprofile = @bip_config.bipprofiles.find(params[:id])
  end
  
  def update
    @bip_config = BipConfig.find(params[:bip_config_id])
    @bipprofile = @bip_config.bipprofiles.find(params[:id])
    @bipprofile.update_attributes(params[:bipprofile])
  end

  def migrate
    @bip_config = BipConfig.find(params[:bip_config_id])
    @bipprofile = @bip_config.bipprofiles.find(params[:bipprofile_id])
    @bipprofile.update_attributes(:migrated => true)
  end
  
  def unmigrate
    @bip_config = BipConfig.find(params[:bip_config_id])
    @bipprofile = @bip_config.bipprofiles.find(params[:bipprofile_id])
    @bipprofile.update_attributes(:migrated => false)
  end
end
