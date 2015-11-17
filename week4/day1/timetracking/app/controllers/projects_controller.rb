class ProjectsController < ApplicationController
	def index
		#@projects = Project.last_created_project(10)
    @projects = Project.last_created_project(10)
    if @projects.empty?
      render template: "others/no_projects"
    else
		  render "index"
    end
	end
  def show
    unless @project = Project.find_by(id: params[:id])
      @project_id = params[:id]
      render "no_project_found"
    else
    render "show"
    end
  end
end
