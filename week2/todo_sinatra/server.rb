require "pry"
require "sinatra"
require "sinatra/reloader" if development?

require_relative("lib/task.rb")
require_relative("lib/todolist.rb")

todo_list = TodoList.new("raoul")
user_default = todo_list.user

#<% binding.pry %>

get "/" do
	redirect to("/tasks")
end

get "/tasks" do
	@user_default = user_default.capitalize
	@todo = todo_list
	erb(:task_index)
end

get "/new_task" do 
	@user_default = user_default.capitalize
	erb(:new_task)
end

post "/create_task" do 
	content = params[:new_task]
	task = Task.new(content)
	todo_list.add_task(task)
	
	todo_list.save
	task_state = task.completed
	#binding.pry
	redirect to("/tasks")
end

post "/complete" do 
	state = params[:state]
	ref = params[:id]
	my_task = todo_list.tasks.select {|task| task.id == ref.to_i}
	#binding.pry
	my_task[0].completed = !my_task[0].completed
	redirect to("/tasks")
end