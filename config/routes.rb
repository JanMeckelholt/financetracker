Rails.application.routes.draw do
  get 'stocks/search'
  get 'users/my_portfolio'
  get 'welcome/index'
  
  post 'stocks/add'
  post 'stocks/remove_stock_from_portfolio'

  #devise_for :users
	
	devise_for :users, :controllers => { :registrations => "user/registrations" }
  
  root 'welcome#index'

  get 'my_friends', to: 'users#my_friends'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
