class MatchesController < ApplicationController

  def show
    #Match.where("winner_id = ? OR loser_id = ?", params[:id], params[:id]")
    matches = Match.joins("INNER JOIN players ON players.id = matches.winner_id OR players.id = matches.loser_id").where("players.id = ?", params[:id])
    render json: matches
  end

  def faction
    all_matches = Match.all
    matches_faction = Match.where("winner_faction = ? OR loser_faction = ?", params[:faction], params[:faction]).joins("INNER JOIN players ON players.id = matches.winner_id").where("players.id = ?", params[:id])
    matches_win_faction = Match.where("winner_faction = ?", params[:faction])
    win_faction_percentage = (matches_win_faction.size.to_f/all_matches.size)*100
    render json: [matches_faction, {"faction_#{params[:faction]}_win_percent" => "#{win_faction_percentage}%"}] 
  end

end
