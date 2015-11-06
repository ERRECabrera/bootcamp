require "rspec"
require_relative "../task.rb"

RSpec.describe "Task" do
	before :all do
		@my_task = Task.new("Rauls first task")
	end

	describe "#initialize" do
		it "creates a new task" do
			expect(@my_task.id).to eq(1)
		end
	end

	describe "#completed?" do
		it "verifies if a task is completed" do
			expect(@my_task.completed?).to be(false)
		end
	end

	describe "#completed!" do
		it "change state of task to completed" do
			expect(@my_task.completed!).to be(true)
		end
	end

	describe "#completed" do
		it "consult state of task" do
			expect(@my_task.completed).to be(true)
		end
	end	

	describe "#make_incomplete!" do
		it "change state of task to uncompleted" do
			expect(@my_task.make_incomplete!).to be(false)
		end
	end

	describe "#created_at" do
		it "set current time in task" do
			expect(@my_task.created_at.to_s).to eq(Time.now.to_s)
		end
	end

	describe "#update_content!" do
		it "change task content" do
			expect(@my_task.update_content!("New Task")).to eq("New Task")
		end
	end

	describe "#update_content!" do
		it "change time task a now" do
		expect(@my_task.update_at.to_s).to eq(Time.now.to_s)
		end
	end

end