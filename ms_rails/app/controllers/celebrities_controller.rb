class CelebritiesController < ApplicationController
  # GET /celebrities
  # GET /celebrities.xml
  def index
    @celebrities = Celebrity.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @celebrities }
    end
  end

  # GET /celebrities/1
  # GET /celebrities/1.xml
  def show
    @celebrity = Celebrity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @celebrity }
    end
  end

  # GET /celebrities/new
  # GET /celebrities/new.xml
  def new
    @celebrity = Celebrity.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @celebrity }
    end
  end

  # GET /celebrities/1/edit
  def edit
    @celebrity = Celebrity.find(params[:id])
  end

  # POST /celebrities
  # POST /celebrities.xml
  def create
    @celebrity = Celebrity.new(params[:celebrity])

    respond_to do |format|
      if @celebrity.save
        flash[:notice] = 'Celebrity was successfully created.'
        format.html { redirect_to(@celebrity) }
        format.xml  { render :xml => @celebrity, :status => :created, :location => @celebrity }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @celebrity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /celebrities/1
  # PUT /celebrities/1.xml
  def update
    @celebrity = Celebrity.find(params[:id])

    respond_to do |format|
      if @celebrity.update_attributes(params[:celebrity])
        flash[:notice] = 'Celebrity was successfully updated.'
        format.html { redirect_to(@celebrity) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @celebrity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /celebrities/1
  # DELETE /celebrities/1.xml
  def destroy
    @celebrity = Celebrity.find(params[:id])
    @celebrity.destroy

    respond_to do |format|
      format.html { redirect_to(celebrities_url) }
      format.xml  { head :ok }
    end
  end
end
