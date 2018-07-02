Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  resources :users, only: [:edit, :update]
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
