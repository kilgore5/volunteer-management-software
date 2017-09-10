Rails.application.routes.draw do

  get 'pages/home'
  get 'pages/terms'

  # Gets all events, and their associated nested resources
  resources :events do
    resources :jobs
    resources :event_days
    resources :application_for_events do
      collection do
        get 'index_all'
      end
    end
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

  # Allows password to be updated
  resource :user, only: [:edit] do
    collection do
      patch 'update_password'
    end
  end

  resources :application_for_events do
    get 'approve', on: :member
    get 'accept_invitation', on: :member
    get 'decline_invitation', on: :member
    get 'submitted'
    collection do
      post 'edit_multiple'
      put  'update_multiple'
      # put  'accept_multiple'
    end
  end

  # resources :application_for_events, :collection => { :accept_multiple => :put }
  patch 'accept_multiple', to: 'application_for_events#accept_multiple', as: :accept_multiple

  root to: "pages#home"
  # root to: "events#show", :id => Event.last.id
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
