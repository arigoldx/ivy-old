class CoursenotesController < ApplicationController
  before_filter :get_variables

  def new
    @coursenote = Coursenote.new
  end
  
  def edit
    @coursenote = Coursenote.find(params[:id])
  end
  
  def create
    @lesson = Lesson.find(params[:coursenote][:lesson_id])
    @coursenote = Coursenote.new(params[:coursenote])
    @coursenote.date = @lesson.date
    if (@course.coursenotes << @coursenote)
      flash[:notice] = 'coursenote was successfully created'
      redirect_to lesson_url(@course,@lesson)
    else
      # i dont get this.  i got the code from the book page 419.
      # whats with these seemingly useless "new" actions?
      # they're everywhere!
      render :action => new
    end
  end
  
  def update
    @coursenote = @course.coursenotes.find(params[:id])
    if @coursenote.update_attributes(params[:coursenote])
      flash[:notice] = 'coursenote was successfully updated'
      redirect_to lesson_url(@course,@coursenote.lesson)
    else
      render :action => :edit
    end
  end
  
  def destroy
    @coursenote = @course.coursenotes.find(params[:id])
    Coursenote.delete(@coursenote)
    redirect_to lesson_url(@course,@coursenote.lesson_id)
  end

  private
  
  def get_variables
    @course_id = params[:course_id]
    redirect_to courses_url unless @course_id
    @course = Course.find(@course_id)
  end
end
