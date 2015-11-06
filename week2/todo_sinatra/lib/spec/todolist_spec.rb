require "rspec"
require_relative "../todolist.rb"

RSpec.describe "TodoList" do

	before :all do
		@my_todolist = TodoList.new("raoul")
		@my_task = Task.new("New Task")
	end

	it "initialize with a name user" do
		expect(@my_todolist.user).to eq("raoul")
	end

	describe "#add_task" do
		it "add one task to todolist" do
			expect(@my_todolist.add_task(@my_task)).to eq([@my_task])
		end
	end

	describe "#find_task_by_id" do
		it "find a task by ID" do
			expect(@my_todolist.find_task_by_id(@my_task.id)).to eq("New Task")			
		end
	end

	describe "#delete_task" do
		it "delete at task by ID" do
			expect(@my_todolist.delete_task(@my_task.id)).to eq([])
		end
	end

	describe "#find_task_by_id" do
		it "find a task by ID" do
			expect(@my_todolist.find_task_by_id(@my_task.id)).to eq(nil)
		end
	end

	describe "#sort by diferent temporal standard" do
		
		it "sorted task by time DESC" do
			3.times do 
				num = 1
				sleep 1
				@my_todolist.add_task(Task.new("Task #{num}"))
				num += 1
			end
			last_time = Time.now.to_s
			expect(@my_todolist.sort_by_created_DESC[2].created_at.to_s).to eq(last_time)
		end

		it "sorted task by time ASC" do
			@my_todolist.add_task(Task.new("Newest Task"))
			last_time = Time.now.to_s
			expect(@my_todolist.sort_by_created_ASC[0].created_at.to_s).to eq(last_time)
		end

	end

end