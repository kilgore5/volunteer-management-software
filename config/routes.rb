Rails.application.routes.draw do

  get 'pages/home'

  resources :events
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  
  resources :users

  root to: "pages#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
