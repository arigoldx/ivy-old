class LessonsController < ApplicationController
    before_filter :load_variables, :except => [ :new, :create ]

    def show
        respond_to do |format|
            format.html # show.rhtml
            format.xml { render :xml => @lesson.to_xml }
        end
    end

    def new
        @course = Course.find(params[:course_id])
    end

    def edit
        @group = @lesson.find_group
    end

    def create
        if params[:start_date]
            @end_date = Date.parse(params[:end_date])
            @current_date = Date.parse(params[:start_date])
            while @current_date.cwday != params[:day_of_week].to_i
                @current_date += 1
            end
            while @current_date <= @end_date
                @lesson = Lesson.new(params[:lesson])
                @lesson.date = @current_date
                @current_date += 7
                @lesson.save
            end
            flash[:notice] = 'your batch of lessons was successfully created'
            redirect_to course_url(params[:lesson][:course_id])
        else
            @lesson = Lesson.new(params[:lesson])
            if @lesson.save
                flash[:notice] = 'your single lesson was successfully created'
                redirect_to course_url(@lesson.course.id)
            else
                # i dont get this.  i got the code from the book page 419.
                # whats with these seemingly useless "new" actions?
                # they're everywhere!
                render :action => new
            end
        end
    end

    def update
        if params[:grouped]
            @group = @lesson.find_group
            @date_diff = @lesson.date - Date.parse(params[:lesson][:date_string])
            @start_time_diff = Time.parse(@lesson.start_time.to_s) - Time.parse(params[:lesson][:start_time_string])
            @end_time_diff = Time.parse(@lesson.end_time.to_s) - Time.parse(params[:lesson][:end_time_string])
            @number_saved = 0
            @group << @lesson
            for member in @group
                @count += 1
                member.date -= @date_diff
                member.start_time -= @start_time_diff
                member.end_time -= @end_time_diff
                member.room = params[:lesson][:room]
                if member.save
                    @number_saved += 1
                end
                flash[:notice] = @number_saved.to_s + " lesson(s) saved."
            end

            redirect_to edit_lesson_path(params[:lesson][:course_id], params[:lesson][:id])
        else
            respond_to do |format|
                if @lesson.update_attributes(params[:lesson])
                    flash[:notice] = 'lesson was successfully updated'
                    format.html { redirect_to course_url(@course) }
                    format.xml { head :ok }
                else
                    format.html { render :action => :edit }
                    format.xml { render :xml => @lesson.errors.to_xml }
                end
            end
        end
    end

    def destroy
        @course.lessons.delete(@lesson)
        redirect_to course_url(@course)
    end

    private

    def load_variables
        @course = Course.find(params[:course_id])
        @lesson_array = @course.lessons.find(:all, :order => "date")
        @lesson = @course.lessons.find(params[:id])
    end
end
