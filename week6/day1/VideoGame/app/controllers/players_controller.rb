class PlayersController < ApplicationController

	def jsonplayers
    tournament = Tournament.find_by_id(params[:id])
		players = Player.all.select do |player|
      !tournament.players.include?(player)
    end
    render status: 200, json: players
	end

  def add_to_tournament
    puts params
    tournament = Tournament.find_by_id(params[:tournament_id])
    player = Player.find_by_name(params[:player_name])
    tournament.players << player
    render status: 200, json: tournament.players
  end

end
