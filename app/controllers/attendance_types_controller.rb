class AttendanceTypesController < ApplicationController
  # GET /attendance_type
  # GET /attendance_type.xml
  def index
    @attendance_types = AttendanceType.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml { render :xml => @attendance_types.to_xml }
    end
  end
  
  # GET /attendance_types/1
  # GET /attendance_types/1.xml
  def show
    @attendance_type = AttendanceType.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml { render :xml => @attendance_type.to_xml }
    end
  end
  
  # GET /attendance_types/new
  def new
    @attendance_type = AttendanceType.new
  end

  # GET /attendance_types/1;edit
  def edit
    @attendance_type = AttendanceType.find(params[:id])
  end
  
  # POST /attendance_types
  # POST /attendance_types.xml
  def create
    @attendance_type = AttendanceType.new(params[:attendance_type])

    respond_to do |format|
      if @attendance_type.save
        flash[:notice] = 'attendance type was successfully saved'
        format.html { redirect_to attendance_types_url }
        format.xml  { head :created, :location => attendance_type_url(@attendance_type) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @article.errors.to_xml }
      end
    end
  end
  
  # PUT /attendance_types/1
  # PUT /attendance_types/1.xml
  def update
    @attendance_type = AttendanceType.find(params[:id])
    
    respond_to do |format|
      if @attendance_type.update_attributes(params[:attendance_type])
        flash[:notice] = 'attendance type was successfully updated'
        format.html { redirect_to attendance_types_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @attendance_type.errors.to_xml }
      end
    end
  end
  
  # DELETE /attendance_types/1
  # DELETE /attendance_types/1.xml
  def destroy
    @attendance_type = AttendanceType.find(params[:id])
    @attendance_type.destroy
    
    respond_to do |format|
      format.html { redirect_to attendance_types_url }
      format.xml { head :ok }
    end
  end
end
