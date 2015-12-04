class Product < ActiveRecord::Base
  validates :title, :description, :deadline, presence: true

  belongs_to :user
  has_many :bids
  has_many :reviews

  def active_bid?
    self.deadline > Date.current.end_of_day
  end

  def get_winner_user
    winner_bid = get_winner_bid
    User.find_by(id: winner_bid.user_id)
  end

  def get_winner_bid
    self.bids.order(amount: :desc).first
  end
end
