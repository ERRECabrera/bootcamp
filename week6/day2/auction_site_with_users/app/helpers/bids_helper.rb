module BidsHelper
  def get_user_name user_id
    user = User.find_by(id: user_id)
    user.name
  end
end
