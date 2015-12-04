class Bid < ActiveRecord::Base
  validates :amount, presence: true
  
  belongs_to :product
end
