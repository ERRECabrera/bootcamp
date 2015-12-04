class Barbecue < ActiveRecord::Base
  validates :title, presence: true
  validates :venue, presence: true
  validates :date, presence: true

  has_many :participations
  has_many :users, through: :participations
  has_many :items
end
