class UsersController < ApplicationController
  
 
  def show
    @user = User.find(current_user.id)
  end

  # private
  # def move_to_root
  #   redirect_to root_path unless user_signed_in?
  # end
end
