class StudentsController < ApplicationController
  # GET /students
  def index
    items_per_page = 10

    sort = case params['sort']
           when "first_name"  then "first_name"
           when "last_name"  then "last_name"
           when "first_name_reverse"  then "first_name DESC"
           when "last_name_reverse"  then "last_name DESC"
           end

    conditions = ["first_name LIKE ?", "%#{params[:query]}%"] unless params[:query].nil?

    @request_type = request.xhr?
    @total = Student.count(:conditions => conditions)
    @students_pages, @students = paginate :students,  :order => sort, :conditions => conditions, :per_page => items_per_page

    if request.xml_http_request?
      render :partial => "list", :layout => false
    end
  end

  # GET /students/1
  # GET /students/1.xml
  def show
    @student = Student.find(params[:id])
    respond_to do |format|
      format.html # show.rhtml
      format.xml { render :xml => @student.to_xml }
    end
  end

  # GET /students/1;edit
  def edit
    @student = Student.find(params[:id])
  end

  # POST /students
  # POST /students.xml
  def create
    course_selection = params[:course][:list].to_i
    @student = Student.new(params[:student])
    respond_to do |format|
      if @student.save
        flash[:notice] = 'student was successfully saved'
        if course_selection > 0
          @course = Course.find(course_selection)
          @course.students << @student
        end
        format.html { redirect_to new_student_url }
        format.xml do
          headers["Location"] = student_url(@student)
          render :nothing => true, :status => "201 Created"
        end
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @article.errors.to_xml }
      end
    end
  end

  # PUT /students/1
  # PUT /students/1.xml
  def update
    @student = Student.find(params[:id])

    respond_to do |format|
      if @student.update_attributes(params[:student])
        format.html { redirect_to student_url(@student) }
        format.xml { render :nothing => true }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @student.errors.to_xml }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.xml
  def destroy
    @student = Student.find(params[:id])
    @student.destroy

    respond_to do |format|
      format.html { redirect_to students_url }
      format.xml { render :nothing => true }
    end
  end
end
