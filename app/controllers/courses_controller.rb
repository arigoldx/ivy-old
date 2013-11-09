class CoursesController < ApplicationController

  # GET /courses
  # GET /courses.xml
  def index
    if params[:date] then
      @date = params[:date].to_date
    else
      @date = Date.today
    end

    @request_type = request.xhr?
    @courses = Course.find(:all)
    # these next lines has nothing to do with the index function of this courses_controller.  lets move it.
    @lessons = Lesson.todays(@date)
    @total = @lessons.size

    if request.xml_http_request?
      render :partial => 'todays_lessons', :layout => false
    end
  end

  # GET /courses/1
  # GET /courses/1.xml
  def show
    @course = Course.find(params[:id])
    @lessons = @course.lessons.find(:all, :order => "date")

    sort = case params['sort']
           when "first_name" then "first_name"
           when "last_name" then "last_name"
           when "attendance_type" then "attendance_type_id"
           when "count" then "count"
           when "first_name_reverse" then "first_name DESC"
           when "last_name_reverse" then "last_name DESC"
           when "attendance_type_reverse" then "attendance_type_id DESC"
           when "count_reverse" then "count DESC"
           end

    conditions = ["attendance_type_id LIKE ?", "%#{params[:query]}%"] unless params[:query].nil?

    @attendances = Attendance.find(:all,
                                   :select => "s.first_name, s.last_name, attendance_type_id, count(*) as count",
                                   :joins => "inner join students as s on student_id = s.id",
                                   :order => sort,
                                   :conditions => "date > '2008-01-26' AND course_id = '#{@course.id}'",
                                   :group => "student_id, attendance_type_id")

    @assignments = AssignmentLog.find(:all)

    if request.xml_http_request?
      render :partial => "attendance_list", :layout => false
    end

  end

  # GET /courses/1;edit
  def edit
    @course = Course.find(params[:id])
  end

  # POST /courses
  # POST /courses.xml
  def create
    @course = Course.new(params[:course])

    respond_to do |format|
      if @course.save
        flash[:notice] = 'course was successfully saved'

        format.html { redirect_to course_url(@course) }
        format.xml do
          headers["Location"] = course_url(@course)
          render :nothing => true, :status => "201 Created"
        end
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @article.errors.to_xml }
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.xml
  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to course_url(@course) }
        format.xml { render :nothing => true }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @course.errors.to_xml }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.xml
  def destroy
    @course = Course.find(params[:id])
    name = @course.name
    @course.destroy
    flash[:notice] = name + ' and all of its lessons, logs, courseplans, coursenotes, and attendances successfully deleted'
    respond_to do |format|
      format.html { redirect_to courses_url }
      format.xml { render :nothing => true }
    end
  end

  def enroll_student
    @course = Course.find(params[:course][:id])
    @student = Student.find(params[:student][:id])
    @course.students << @student
    redirect_to course_url(@course)
  end
end
