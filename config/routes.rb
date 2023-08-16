Rails.application.routes.draw do
  require 'sidekiq/web'
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }
  get 'travelplans/home/:id', to: 'travelplans#home', as: 'travelplans_home'

  resources :travelplans
  resources :users, only: [:show]

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    root 'travelplans#home'
  end

  mount Sidekiq::Web => '/sidekiq'
end
