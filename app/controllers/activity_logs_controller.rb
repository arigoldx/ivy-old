class ActivityLogsController < ApplicationController
  # GET /activity_logs/new
  def new
    @activity_log = ActivityLog.new
  end

  # GET /activity_logs/1;edit
  def edit
    @activity_log = ActivityLog.find(params[:id])
  end

  # POST /activity_logs
  # POST /activity_logs.xml
  def create
    for activity_id in params[:activities]
      @activity_log = ActivityLog.new(params[:activity_log])
      @activity_log.activity_id = activity_id
      @activity_log.date = @activity_log.lesson.date
      @activity_log.save
    end
    respond_to do |format|
      if @activity_log.save
        flash[:notice] = 'logging activity successfully completed'
        format.html { redirect_to lesson_path(@activity_log.course_id, @activity_log.lesson) }
        format.xml  { head :created, :location => activity_log_url(@activity_log) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @activity_log.errors.to_xml }
      end
    end
  end

  # PUT /activity_logs/1
  # PUT /activity_logs/1.xml
  def update
    @activity_log = ActivityLog.find(params[:id])

    respond_to do |format|
      if @activity_log.update_attributes(params[:activity_log])
        flash[:notice] = 'activity_log was successfully updated'
        format.html { redirect_to lesson_path(@activity_log.lesson.course_id, @activity_log.lesson) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @activity_log.errors.to_xml }
      end
    end
  end

  # DELETE /activity_logs/1
  # DELETE /activity_logs/1.xml
  def destroy
    @activity_log = ActivityLog.find(params[:id])
    course = @activity_log.course
    lesson = @activity_log.lesson
    @activity_log.destroy

    respond_to do |format|
      format.html { redirect_to lesson_path(course, lesson) }
      format.xml  { head :ok }
    end
  end
end
