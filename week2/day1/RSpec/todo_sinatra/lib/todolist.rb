require "rspec"
require "yaml/store"
require "yaml"

class TodoList

  attr_reader :tasks, :user

  def initialize(name_user)
  	@user = name_user
    @tasks = []
    @todo_store = YAML::Store.new("./public/task.yml")
  end

  def add_task(task)
  	@tasks << task
  end

  def delete_task(id_task)
  	@tasks.delete_if {|task| task.id == id_task}
  end

  def find_task_by_id(id_task)
  	task_found = @tasks.find {|task| task.id == id_task}
  	if task_found != nil
  		task_found.content
  	else
  		nil
  	end
  end

  def sort_by_created_DESC
  	sorted_task = @tasks.sort {|task1,task2| task1.created_at <=> task2.created_at}
  end

  def sort_by_created_ASC
      sorted_task = @tasks.sort {|task1,task2| task2.created_at <=> task1.created_at}
  end

  def save
    @todo_store.transaction do 
    @todo_store[@user] = @tasks
  end

  def load_tasks
    load_tasks = YAML.load_file("./public/task.yml")
    @tasks = load_tasks[@user]    
  end
end

end