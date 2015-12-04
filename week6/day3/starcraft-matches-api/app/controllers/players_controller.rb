class PlayersController < ApplicationController

  def show
    matches = Match.where("winner_id = ? OR loser_id = ?", params[:id], params[:id])
    win_matches = Match.where("winner_id = ?", params[:id]).size
    los_matches = Match.where("loser_id = ?", params[:id]).size
    win_percent = (win_matches/matches.size.to_f)*100
    los_percent = (los_matches/matches.size.to_f)*100
    hash_win_los = Player.return_hash_win_and_los_integer_by_faction(matches)
    render json: [matches,
      {"win_percent" => "#{win_percent}%"},
      {"los_percent" => "#{los_percent}%"},
      hash_win_los
    ]
  end

end
