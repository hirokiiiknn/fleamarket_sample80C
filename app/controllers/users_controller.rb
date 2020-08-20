class UsersController < ApplicationController
  # before_action :set_sale_items,   only:   [:index, :show]
 
  def index
  end
  
  def show
    @user = User.find(current_user.id)
  end

  private

  # def set_sale_items
  #   @sale_items = Item.where(user_id: current_user.id).where(quantity != 0).includes(:images)
  # end

  # private
  # def move_to_root
  #   redirect_to root_path unless user_signed_in?
  # end
end
