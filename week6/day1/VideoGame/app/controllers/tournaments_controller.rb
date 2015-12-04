class TournamentsController < ApplicationController
  def index
    render(:index)
  end

  def jsontournament
  	tournaments = Tournament.all
  	if tournaments
  	render status: 200, json: tournaments
  	else
  	render status: 404
  	end
  end

  def create
  	tournament = Tournament.create(tournament_params)
  	render status: 201, html: 'index', json: tournament
  end

  def destroy
  	tournament = Tournament.find_by(id: params[:id])

  	if tournament
  		tournament.destroy
  		render status: 204
  	else
  		render status: 404
  	end
  end

  private
  def tournament_params
  	params.require(:tournament).permit(:name)
  end
end
