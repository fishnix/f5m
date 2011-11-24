class BipprofilesController < ApplicationController
  # GET /bipprofiles
  # GET /bipprofiles.xml
  def index
    @bipprofiles = Bipprofile.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bipprofiles }
    end
  end

  # GET /bipprofiles/1
  # GET /bipprofiles/1.xml
  def show
    @bipprofile = Bipprofile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bipprofile }
    end
  end

  # GET /bipprofiles/new
  # GET /bipprofiles/new.xml
  def new
    @bipprofile = Bipprofile.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bipprofile }
    end
  end

  # GET /bipprofiles/1/edit
  def edit
    @bipprofile = Bipprofile.find(params[:id])
  end

  # POST /bipprofiles
  # POST /bipprofiles.xml
  def create
    @bipprofile = Bipprofile.new(params[:bipprofile])

    respond_to do |format|
      if @bipprofile.save
        format.html { redirect_to(@bipprofile, :notice => 'Bipprofile was successfully created.') }
        format.xml  { render :xml => @bipprofile, :status => :created, :location => @bipprofile }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bipprofile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bipprofiles/1
  # PUT /bipprofiles/1.xml
  def update
    @bipprofile = Bipprofile.find(params[:id])

    respond_to do |format|
      if @bipprofile.update_attributes(params[:bipprofile])
        format.html { redirect_to(@bipprofile, :notice => 'Bipprofile was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bipprofile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bipprofiles/1
  # DELETE /bipprofiles/1.xml
  def destroy
    @bipprofile = Bipprofile.find(params[:id])
    @bipprofile.destroy

    respond_to do |format|
      format.html { redirect_to(bipprofiles_url) }
      format.xml  { head :ok }
    end
  end
end
