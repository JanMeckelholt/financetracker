class StocksController < ApplicationController
def search
  if params[:stock].present?
    @stock = Stock.new_from_lookup(params[:stock])
    if @stock
      respond_to do |format|
        format.js { render partial: 'stocks/result' }
      end
    else
      flash.now[:danger] = "You have entered an incorrect symbol"
      redirect_to stocks_search_path
    end
  else
    flash.now[:danger] = "You have entered an empty search string"
    redirect_to stocks_search_path
  end
end
end
