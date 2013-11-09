class EnrollmentsController < ApplicationController

  # POST /enrollments
  # POST /enrollments.xml
  def create
    @enrollment = Enrollment.new(params[:enrollment])

    respond_to do |format|
      if @enrollment.save
        flash[:notice] = @enrollment.student.name_first_last + ' enrolled'
        format.html { redirect_to course_url(@enrollment.course_id) }
        format.xml  { head :created, :location => enrollment_url(@enrollment) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @enrollment.errors.to_xml }
      end
    end
  end

  # DELETE /enrollments/1
  # DELETE /enrollments/1.xml
  def destroy
    @enrollment = Enrollment.find(params[:id])
    student = @enrollment.student
    course_id = @enrollment.course_id
    @enrollment.destroy

    respond_to do |format|
      flash[:notice] = student.name_first_last + ' unenrolled'
      format.html { redirect_to course_url(course_id) }
      format.xml  { head :ok }
    end
  end
end
