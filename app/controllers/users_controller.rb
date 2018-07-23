class UsersController < ApplicationController
  def my_portfolio
  #	@user_stocks = current_user.stocks
  #	@user = current_user
  end

  def my_friends
  	@my_friends = current_user.friends
  end

  def remove_friend
		friend = User.where(id: params[:friend])
		
		user_friend = Friendship.where(user: current_user, friend: friend)

		
		
		if user_friend.delete
			flash[:success] = "Friendship deleted"
			redirect_to my_friends_path
		else
			flash[:danger] = "Friendship could not be deleted."
			redirect_to my_friends_path
		end
	end

end
