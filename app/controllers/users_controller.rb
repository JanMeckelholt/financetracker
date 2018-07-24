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
		user_friend = Friendship.where(user: current_user, friend: friend).first
		if user_friend.delete
			flash[:success] = "Friendship deleted"
			redirect_to my_friends_path
		else
			flash[:danger] = "Friendship could not be deleted."
			redirect_to my_friends_path
		end
	end

	def add_friend
		friend = User.find_by_email(params[:friend_email])
		if friend == current_user
			flash[:danger] = "You can not add yourself!"
			redirect_to my_friends_path
		else
			new_friendship = Friendship.new(user: current_user, friend: friend)
			if new_friendship.save
				flash[:success] = "Friend added"
				redirect_to my_friends_path
			else
				flash[:danger] = "Friend could not be added."
				redirect_to my_friends_path
			end
		end
	end



	def show_friend
		@friend = User.find(id: params[:friend])
	end

	def search_friend

	  if params[:friend_email].present?
	    @friend = User.find_by_email(params[:friend_email].downcase)
	    if @friend
	      respond_to do |format|
	      	format.html
	        format.js { render partial: 'users/result' }
	      end
	    else
	    	respond_to do |format|
	    		format.html
	        
	        format.js { 
	        	flash.now[:danger] = "E-Mail not found!"
	        	render partial: 'users/result' 
	        }
	  	  end
	  	end
	  else
	  	respond_to do |format|
	  		format.html
	    	
	    	format.js {
					flash.now[:danger] = "You have entered an empty search string"
	    		render  partial: 'users/result' 
	    	}
	  	end
		end
	end

end
