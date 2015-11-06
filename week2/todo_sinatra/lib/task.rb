require "rspec"

class Task
    attr_reader :content, :id, :created_at, :update_at
    attr_accessor :completed
    @@current_id = 1
    def initialize(content)
      @content = content
      @id = @@current_id
      @@current_id += 1
      @completed = false
      @created_at = Time.now
      @update_at = nil
    end

    def completed?
    	@completed == true
    end

    def completed!
    	@completed = true
    end

    def make_incomplete!
    	@completed = false
    end

    def update_content!(new_content)
    	@update_at = Time.now
    	@content = new_content    	
    end
end



