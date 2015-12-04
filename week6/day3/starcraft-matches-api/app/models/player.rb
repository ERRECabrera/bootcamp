class Player < ActiveRecord::Base
  has_many :matches

  def self.return_hash_win_and_los_integer_by_faction(data_arr)
    factions =  %w{ terrans zergs protoss}
    hash = {}
    factions.each do |faction|
      wins = data_arr.where('winner_faction = ?', faction)
      losses = data_arr.where('loser_faction = ?', faction)
      hash[faction] = {wins: wins.size, loss: losses.size}
    end
    return hash
  end

end
