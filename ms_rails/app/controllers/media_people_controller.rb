class MediaPeopleController < ApplicationController
  # GET /media_people
  # GET /media_people.xml
  def index
    @media_people = MediaPerson.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @media_people }
    end
  end

  # GET /media_people/1
  # GET /media_people/1.xml
  def show
    @media_person = MediaPerson.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @media_person }
    end
  end

  # GET /media_people/new
  # GET /media_people/new.xml
  def new
    @media_person = MediaPerson.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @media_person }
    end
  end

  # GET /media_people/1/edit
  def edit
    @media_person = MediaPerson.find(params[:id])
  end

  # POST /media_people
  # POST /media_people.xml
  def create
    @media_person = MediaPerson.new(params[:media_person])

    respond_to do |format|
      if @media_person.save
        flash[:notice] = 'MediaPerson was successfully created.'
        format.html { redirect_to(@media_person) }
        format.xml  { render :xml => @media_person, :status => :created, :location => @media_person }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @media_person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /media_people/1
  # PUT /media_people/1.xml
  def update
    @media_person = MediaPerson.find(params[:id])

    respond_to do |format|
      if @media_person.update_attributes(params[:media_person])
        flash[:notice] = 'MediaPerson was successfully updated.'
        format.html { redirect_to(@media_person) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @media_person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /media_people/1
  # DELETE /media_people/1.xml
  def destroy
    @media_person = MediaPerson.find(params[:id])
    @media_person.destroy

    respond_to do |format|
      format.html { redirect_to(media_people_url) }
      format.xml  { head :ok }
    end
  end
end
