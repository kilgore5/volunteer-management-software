Rails.application.routes.draw do

  get 'pages/home'

  # Gets all events, and their associated nested resources
  resources :events do
    resources :jobs
    resources :event_days
    resources :application_for_events
  end

  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  
  resources :users  do
    resources :events do
      resources :application_for_events
    end
  end

  root to: "pages#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
