class Stock < ApplicationRecord
has_many :user_stocks
has_many :users, through: :user_stocks

def self.new_from_lookup(ticker_symbol)
	looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
	if looked_up_stock 
	  new(name: looked_up_stock.company_name, last_price: looked_up_stock.latest_price, ticker: looked_up_stock.symbol)

	end
end

def self.strip_commas(number)
  number.gsub(",", "")
end

end
