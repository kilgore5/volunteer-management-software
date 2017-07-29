Rails.application.routes.draw do

  get 'pages/home'
  get 'pages/terms'

  # Gets all events, and their associated nested resources
  resources :events do
    resources :jobs
    resources :event_days
    resources :application_for_events
  end

  resources :event_days do
    resources :rotations
  end

  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  
  resources :users  do
    resources :events do
      resources :application_for_events
    end
  end

  resources :application_for_events do
    get 'approve', on: :member
    get 'submitted'
  end

  root to: "pages#home"
  # root to: "events#show", :id => Event.last.id
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # SSL
  # https://collectiveidea.com/blog/archives/2016/01/12/lets-encrypt-with-a-rails-app-on-heroku
  get '/.well-known/acme-challenge/:id' => 'pages#letsencrypt'
end
