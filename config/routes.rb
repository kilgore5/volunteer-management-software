Rails.application.routes.draw do

  get 'pages/home'

  # Gets all events, and their associated nested resources
  resources :events do
    resources :jobs
    resources :event_days
  end

  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  
  resources :users

  root to: "pages#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
