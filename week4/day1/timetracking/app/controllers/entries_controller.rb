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

  private

  def entry_params
    params.require(:entry).permit(:hours, :minutes, :date)
  end

end
