class Project < ActiveRecord::Base
  has_many :entries

  validates :name, uniqueness: true
  validates :name, presence: true
  validates :name, length: {maximum: 30}
  validates :name, format: {with: /\A[\wÑñ\ ]+\z/}

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

  def total_hours_in_month(month_number,year)
    project_date = DateTime.new(year,month_number)
    date_start = project_date.at_beginning_of_month
    date_end = project_date.end_of_month
    entries = self.entries.where(date: date_start..date_end)
    hours = entries.reduce(0.0) do |sum,entry|
      sum+(entry.hours*60)+entry.minutes
    end
    (hours/60).round
  end
end