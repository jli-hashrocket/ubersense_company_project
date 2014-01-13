UbersenseLaunchAcademy::Application.routes.draw do
  root to: 'people#index'

  resources :people
  
  resources :teammates

	get '/login', to: 'login#index', as: 'login'
	post '/login', to: 'login#index'

	delete '/logout', to: 'login#logout', as: 'logout'

end
