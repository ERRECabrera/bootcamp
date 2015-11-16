class ProjectsController < ApplicationController
	def index
		#@projects = Project.last_created_project(10)
    @projects = Project.first_updated(10)
		render "index"
	end
end
