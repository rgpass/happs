Happs::Application.routes.draw do
  get "examples/profile_complete"
  get "examples/profile_start"
  get "examples/ohq"
  get "examples/activity"

  # AJAX routes
  get "users/ohq_data"
  get "users/pafd_data"

  match "/15CAA848590025BB3B93F642928894E0.txt", to: "static_pages#ssl_validation", via: 'get'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :subjective_happiness_scales
  resources :ohqs, only: [:new, :create]
  resources :pafds, only: [:new, :create]
  
  root 'static_pages#home'

  match '/help',			to: 'static_pages#help',			via: 'get'
  match '/about',			to: 'static_pages#about',			via: 'get'
  match '/research',	to: 'static_pages#research',	via: 'get'

  match '/signup',		to: 'users#new', 							via: 'get'
  match '/signin',		to: 'sessions#new',						via: 'get'
  match '/signout', 	to: 'sessions#destroy',				via: 'delete'
end
