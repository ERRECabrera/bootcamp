class Match < ActiveRecord::Base
  belongs_to :winner, class_name: 'player'
  belongs_to :loser, class_name: 'player'
end
