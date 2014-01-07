UbersenseLaunchAcademy::Application.routes.draw do
  root to: 'teammates#index'

	get '/login', to: 'login#index', as: 'login'
	post '/login', to: 'login#index'
end
