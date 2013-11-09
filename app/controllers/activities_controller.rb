class ActivitiesController < ApplicationController

  # GET /activity
  # GET /activity.xml
  def index
    @activities = Activity.find(:all, :order => "name")
    respond_to do |format|
      format.html # index.rhtml
      format.xml { render :xml => @activities.to_xml }
    end
  end
  
  # GET /activities/1
  # GET /activities/1.xml
  def show
    @activity = Activity.find(params[:id])
    respond_to do |format|
      format.html # show.rhtml
      format.xml { render :xml => @activity.to_xml }
    end
  end
  
  # GET /activities/1;edit
  def edit
    @activity = Activity.find(params[:id])
  end
  
  # POST /activities
  # POST /activities.xml
  def create
    @activity = Activity.new(params[:activity])
    respond_to do |format|
      if @activity.save
        flash[:notice] = 'activity was successfully saved'
        format.html { redirect_to activities_url }
        format.xml do
          headers["Location"] = activity_url(@activity)
          render :nothing => true, :status => "201 Created"
        end
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @article.errors.to_xml }
      end
    end
  end
  
  # PUT /activities/1
  # PUT /activities/1.xml
  def update
    @activity = Activity.find(params[:id])
    
    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        format.html { redirect_to activities_path }
        format.xml { render :nothing => true }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @activity.errors.to_xml }
      end
    end
  end
  
  # DELETE /activities/1
  # DELETE /activities/1.xml
  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy
    
    respond_to do |format|
      format.html { redirect_to activities_url }
      format.xml { render :nothing => true }
    end
  end
end
