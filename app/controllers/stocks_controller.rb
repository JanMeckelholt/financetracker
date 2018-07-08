class StocksController < ApplicationController
  def search
  	unless params[:stock].blank?
  		@stock = Stock.new_from_lookup(params[:stock])
  		if @stock == nil
	  	  flash[:warning] = "Stock not found!"
	  	 end
	  	  
  	end
  end
end
