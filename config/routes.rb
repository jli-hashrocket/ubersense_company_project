UbersenseLaunchAcademy::Application.routes.draw do
  root to: 'teammates#index'

  resources :teammates

	get '/login', to: 'login#index', as: 'login'
	post '/login', to: 'login#index'

end
