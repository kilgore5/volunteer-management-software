Rails.application.routes.draw do

  resources :events
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  
  resources :users

  root to: "users#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
