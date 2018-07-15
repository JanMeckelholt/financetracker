class StocksController < ApplicationController
	
	def search
	  if params[:stock].present?
	    @stock = Stock.new_from_lookup(params[:stock])
	    if @stock
	      respond_to do |format|
	      	format.html
	        format.js { render partial: 'stocks/result' }
	      end
	    else
	    	respond_to do |format|
	    		format.html
	        
	        format.js { 
	        	flash.now[:danger] = "You have entered an incorrect symbol2"
	        	render partial: 'stocks/result' 
	        }
	  	  end
	  	end
	  else
	  	respond_to do |format|
	  		format.html
	    	
	    	format.js {
					flash.now[:danger] = "You have entered an empty search string2"
	    		render  partial: 'stocks/result' 
	    	}
	  	end
		end
	end

	def add
		if params[:stock].present?
	    @stock = Stock.new_from_lookup(params[:stock])
			duplicate = false
			current_user.stocks.each do |stock|
				if stock.ticker == @stock.ticker
					duplicate = true
				end
			end
			if duplicate
				flash[:danger] = "Stock already included in Portfolio"
				redirect_to users_my_portfolio_path(current_user)
			else
				@stock.users.append(current_user)
				if @stock.save 
					flash[:success] = "Stock added to Portfolio"
					redirect_to users_my_portfolio_path(current_user)
				else
					flash[:danger] = "Stock could not be added"
					redirect_to users_my_portfolio_path(current_user)
				end
			end
		end
	end

	def remove_stock_from_portfolio
		stock = Stock.where(ticker: params[:stock])
		
		us = UserStock.where(user: current_user)

		
		
		if us.delete(stock)
			flash[:success] = "Stock removed from Portfolio"
			redirect_to users_my_portfolio_path(current_user)
		else
			flash[:danger] = "Stock could not be removed"
			redirect_to users_my_portfolio_path(current_user)
		end
	end


end

