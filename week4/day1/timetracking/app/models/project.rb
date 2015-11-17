class Project < ActiveRecord::Base
  has_many :entries

	def self.iron_find(params)
		where(params).first
	end

	def self.clean_old
		where("update_at < ?", Date.today - 1.week).destroy_all
	end

  def self.last_created_project(limit)
    order("id DESC").limit(limit)
  end
  
  def self.first_updated(limit)
    order("updated_at ASC").limit(limit)
  end
end
