class Project < ActiveRecord::Base
	def self.iron_find(params)
			where(params).first
	end
end
