class StocksController < ApplicationController
	
	def search
	  if params[:stock].present?
	    @stock = Stock.new_from_lookup(params[:stock])
	    if @stock
	      respond_to do |format|
	        format.js { render partial: 'stocks/result' }
	      end
	    else
	    	respond_to do |format|
	        flash.now[:danger] = "You have entered an incorrect symbol2"
	        format.js { render partial: 'stocks/result' }
	  	  end
	  	end
	  #else
	  #	respond_to do |format|
	   # 	flash.now[:danger] = "You have entered an empty search string2"
	    #	format.js {render  partial: 'stocks/result' }
	  	#end
		end
	end

end
