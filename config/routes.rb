Happs::Application.routes.draw do
  get "examples/profile_complete"
  get "examples/profile_start"
  get "examples/ohq"
  get "examples/activity"

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :subjective_happiness_scales
  
  root 'static_pages#home'

  match '/help',			to: 'static_pages#help',			via: 'get'
  match '/about',			to: 'static_pages#about',			via: 'get'
  match '/research',	to: 'static_pages#research',	via: 'get'

  match '/signup',		to: 'users#new', 							via: 'get'
  match '/signin',		to: 'sessions#new',						via: 'get'
  match '/signout', 	to: 'sessions#destroy',				via: 'delete'
end
