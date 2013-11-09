class CourseplansController < ApplicationController

  def new
    @courseplan = Courseplan.new
  end

  # GET /courseplan/1;edit
  def edit
    @courseplan = Courseplan.find(params[:id])
  end

  # POST /courseplan
  # POST /courseplan.xml
  def create
    @courseplan = Courseplan.new(params[:courseplan])
    @courseplan.date = @courseplan.lesson.date
    respond_to do |format|
      if @courseplan.save
        flash[:notice] = 'courseplan was successfully created'
        format.html { redirect_to lesson_url(@courseplan.course,@courseplan.lesson) }
        format.xml  { head :created, :location => lesson_url(@courseplan.course,@courseplan.lesson) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @courseplan.errors.to_xml }
      end
    end
  end

  # PUT /courseplan/1
  # PUT /courseplan/1.xml
  def update
    @courseplan = Courseplan.find(params[:id])

    respond_to do |format|
      if @courseplan.update_attributes(params[:courseplan])
        flash[:notice] = 'courseplan was successfully updated'
        format.html { redirect_to lesson_url(@courseplan.course,@courseplan.lesson) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @courseplan.errors.to_xml }
      end
    end
  end

  # DELETE /courseplan/1
  # DELETE /courseplan/1.xml
  def destroy
    @courseplan = Courseplan.find(params[:id])
    @courseplan.destroy

    respond_to do |format|
      format.html { redirect_to lesson_url(@courseplan.course,@courseplan.lesson) }
      format.xml  { head :ok }
    end
  end
end
