Rails.application.routes.draw do

  get 'pages/home'
  get 'pages/terms'

  # Gets all events, and their associated nested resources
  resources :events do
    resources :jobs
    resources :event_days
    resources :applies
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
      resources :applies
    end
  end

  # Allows password to be updated
  resource :user, only: [:edit] do
    collection do
      patch 'update_password'
    end
  end

  resources :applies do
    get 'approve',            on: :member
    get 'accept_invitation',  on: :member
    get 'decline_invitation', on: :member
    get 'submitted'
    collection do
      post 'edit_multiple'
      put  'update_multiple'
    end
  end


  patch 'accept_multiple', to: 'applies#accept_multiple', as: :accept_multiple

  root to: "pages#home"
  # root to: "events#show", :id => Event.last.id
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
