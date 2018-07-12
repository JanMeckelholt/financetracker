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

end
