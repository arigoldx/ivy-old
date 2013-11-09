class AssignmentLogsController < ApplicationController
  # GET /assignment_logs
  # GET /assignment_logs.xml
  def index
    @assignment_logs = AssignmentLog.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @assignment_logs.to_xml }
    end
  end

  # GET /assignment_logs/1
  # GET /assignment_logs/1.xml
  def show
    @assignment_log = AssignmentLog.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @assignment_log.to_xml }
    end
  end

  # GET /assignment_logs/new
  def new
      @assignment_log = AssignmentLog.new
      @assignment_log.course_id = params[:course_id] if params[:course_id]
      @course = Course.find(params[:course_id])
      @assignments = Assignment.find(:all)
  end

  # GET /assignment_logs/1;edit
  def edit
    @assignment_log = AssignmentLog.find(params[:id])
  end

  # POST /assignment_logs
  # POST /assignment_logs.xml
  def create
      student_list = ""
      if !params[:student]
          @assignment_log = AssignmentLog.new(params[:assignment_log])
          @assignment_log.save
          flash[:notice] = @assignment_log.assignment.name + " logging started for " + @assignment_log.course.full_name
      else
          for student_id in params[:student]
              @assignment_log = AssignmentLog.new(params[:assignment_log])
              @assignment_log.student_id = student_id
              @assignment_log.submitted_date = Time.now
              @assignment_log.save
              if student_list.empty?
                  student_list = @assignment_log.student.name_first_last
              else
                  student_list << ", " + @assignment_log.student.name_first_last
              end
          end
          flash[:notice] = @assignment_log.assignment.name + ' marked complete for: ' + student_list
      end

      redirect_to course_url(@assignment_log.course.id)
  end

  # PUT /assignment_logs/1
  # PUT /assignment_logs/1.xml
  def update
    @assignment_log = AssignmentLog.find(params[:id])

    respond_to do |format|
      if @assignment_log.update_attributes(params[:assignment_log])
        flash[:notice] = 'AssignmentLog was successfully updated.'
        format.html { redirect_to assignment_log_url(@assignment_log) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @assignment_log.errors.to_xml }
      end
    end
  end

  # DELETE /assignment_logs/1
  # DELETE /assignment_logs/1.xml
  def destroy
      @assignment_log = AssignmentLog.find(params[:id])
      student_id = @assignment_log.student_id ? @assignment_log.student_id : ""
      course_id = @assignment_log.course_id
      flash[:notice] = "log for " + @assignment_log.assignment.name + " destroyed."
      @assignment_log.destroy


    respond_to do |format|
      format.html {
              if student_id.to_s.empty?
                  redirect_to course_url(course_id)
              else
                  redirect_to assignment_logs_url
              end
          }
      format.xml  { head :ok }
    end
  end
end
