class EntriesController < ApplicationController
  def index
    date = Date.current
    @project = Project.find(params[:project_id])
    @entries = @project.entries.where(date: date.beginning_of_month..date.end_of_month)
    @total_hours = @project.total_hours_in_month(date.month,date.year)
    render "index"
    #@entries = Entry.where(project_id: params[:id])
  end
end
