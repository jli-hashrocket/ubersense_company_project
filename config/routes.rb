UbersenseLaunchAcademy::Application.routes.draw do
  root to: 'teammates#index'

  resources :teammates do
    collection { post :import }
  end
  resources :people, only: [:edit, :update, :destroy]

	get '/login', to: 'login#index', as: 'login'
	post '/login', to: 'login#index'

	delete '/logout', to: 'login#logout', as: 'logout'

end
