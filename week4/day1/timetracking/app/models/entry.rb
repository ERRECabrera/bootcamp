class Entry < ActiveRecord::Base
  belongs_to :project

  validates :hours, :minutes, numericality: {only_integer: true}
  validates :hours, :minutes, :date, presence: true
  validates :project_id, presence: true

end
