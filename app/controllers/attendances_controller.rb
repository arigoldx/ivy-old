class AttendancesController < ApplicationController
    # GET /attendances
    # GET /attendances.xml
    def index
        sort = case params['sort']
               when "first_name" then "first_name"
               when "last_name" then "last_name"
               when "attendance_type" then "attendance_type_id"
               when "course" then "course_id"
               when "count" then "count"
               when "first_name_reverse" then "first_name DESC"
               when "last_name_reverse" then "last_name DESC"
               when "attendance_type_reverse" then "attendance_type_id DESC"
               when "course_reverse" then "course_id DESC"
               when "count_reverse" then "count DESC"
               end

        if params[:query].nil?
            conditions = "date > '2008-01-26'"
        else
            conditions = ["date > '2008-01-26' AND attendance_type_id LIKE ?", "%#{params[:query]}%"]
        end

        @total = Attendance.count(:conditions => conditions)

        @attendances = Attendance.find(:all,
                                       :select => "s.first_name, s.last_name, attendance_type_id, course_id, count(*) as count",
                                       :joins => "inner join students as s on student_id = s.id",
                                       :order => sort,
                                       :conditions => conditions,
                                       :group => "student_id, attendance_type_id")

        if request.xml_http_request?
            render :partial => "list", :layout => false
        end
    end

    # GET /attendances/1
    # GET /attendances/1.xml
    def show
        @attendance = Attendance.find(params[:id])

        respond_to do |format|
            format.html # show.rhtml
            format.xml  { render :xml => @attendance.to_xml }
        end
    end

    # GET /attendances/new
    def new
        @attendance = Attendance.new
    end

    # GET /attendances/1;edit
    def edit
        @attendance = Attendance.find(params[:id])
    end

    # POST /attendances
    # POST /attendances.xml
    def create
        student_list = ""
        for student_id in params[:student]
            @attendance = Attendance.new(params[:attendance])
            @attendance.student_id = student_id
            @attendance.date = @attendance.lesson.date
            @attendance.save
            if student_list.empty?
                student_list = @attendance.student.name_first_last
            else
                student_list << ", " + @attendance.student.name_first_last
            end

        end
        flash[:notice] = student_list + ' marked ' + @attendance.attendance_type.name
        redirect_to lesson_url(@attendance.course.id,@attendance.lesson.id)
    end

    # PUT /attendances/1
    # PUT /attendances/1.xml
    def update
        @attendance = Attendance.find(params[:id])

        respond_to do |format|
            if @attendance.update_attributes(params[:attendance])
                flash[:notice] = 'attendance was successfully updated'
                format.html { redirect_to lesson_url(@attendance.course.id,@attendance.lesson.id) }
                format.xml  { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => @attendance.errors.to_xml }
            end
        end
    end

    # DELETE /attendances/1
    # DELETE /attendances/1.xml
    def destroy
        @attendance = Attendance.find(params[:id])
        lesson = @attendance.lesson
        course = @attendance.course
        @attendance.destroy

        respond_to do |format|
            format.html { redirect_to lesson_url(course.id,lesson.id) }
            format.xml  { head :ok }
        end
    end
end
