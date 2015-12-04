class ApiBbqController < ApplicationController
  before_action :authenticate_user!
  before_action :get_barbecue

  def json_bbq
    barbecue = ActiveSupport::JSON.encode(@barbecue)
    end_bracket = barbecue[-1]
    barbecue = barbecue.delete!(end_bracket)
    items = ",\"items\":" + ActiveSupport::JSON.encode(@barbecue.items) + end_bracket
    barbecue_with_items = barbecue + items
    render json: ActiveSupport::JSON.decode(barbecue_with_items)
  end

  def user_join
    @barbecue.users << current_user
    #association = Participation.new(user_id: current_user.id, barbecue_id: params[:id])
    if @barbecue.users.last == current_user#association.save
      render status: 201, json: [@barbacue, current_user]#association
    else
      render status: 404, json: {error: "No he podido añadirte a la bbq!"}
    end
  end

  def item_create
    item = Item.new(name: strong_params_item[:name], barbecue_id: params[:id])
    if item.save
      redirect_to barbecue_path(params[:id])
    else
      redirect_to barbecue_path(params[:id])
    end
  end

  def get_barbecue
    @barbecue = Barbecue.find_by_id(params[:id])
  end

private

  def strong_params_item
    params.require(:item).permit(:name)
  end

  def strong_params_bbq
    params.permit(:id)
  end

end
