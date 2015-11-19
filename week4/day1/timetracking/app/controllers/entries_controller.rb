class EntriesController < ApplicationController
  def index
    date = Date.current
    @project = Project.find(params[:project_id])
    @entries = @project.entries.where(date: date.beginning_of_month..date.end_of_month)
    @total_hours = @project.total_hours_in_month(date.month,date.year)
    render "index"
    #@entries = Entry.where(project_id: params[:id])
  end

  def new
    @project = Project.find(params[:project_id])
    @entry = @project.entries.new    
  end

  def create
    #entry = params[:entry]
    #project_id = params[:project_id]
    #entry.merge(project_id)
    #Entry.create(entry)
    #if Entry.last.valid?
    @project = Project.find(params[:project_id])
    @entry = @project.entries.new(entry_params)
    if @entry.save
      redirect_to action: "index", controller: "entries", project_id: @project.id 
      #esto se pasa como params
    else
      render "new"
    end
    #redirect_to "index"
  end

  def edit
    @project = Project.find(params[:project_id])
    @entry = @project.entries.find(params[:id])
    #http://localhost:3000/projects/23/entries/10/edit
  end

  def update
    #Find the project
    @project = Project.find(params[:project_id])
    #Find entry to update
    @entry = @project.entries.find(params[:id])
    #update the entry using update_attributes
    #if ok redirect_to entries index
    if @entry.update_attributes(entry_params)
      redirect_to(controller: "entries", action: "index", project_id: @project.id)
    #if wrong show the form again
    else
      render "edit"
    end
  end

  def destroy
    project = Project.find(params[:project_id])
    entry = project.entries.find(params[:id])
    entry.destroy
    redirect_to(controller: "entries", action: "index", project_id: project.id)
  end

  private

  def entry_params
    params.require(:entry).permit(:hours, :minutes, :date)
  end

end
