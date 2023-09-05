Rails.application.routes.draw do
  require 'sidekiq/web'
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }
  get 'travelplans/home/:id', to: 'travelplans#home', as: 'travelplans_home'

  resources :travelplans  do
    member do
      post :set_in_progress
      post :likes, to: 'likes#create', as: :create_like
      delete :likes, to: 'likes#destroy', as: :destroy_like
    end
  end

  resources :users, only: [:show, :edit, :update] do
    collection do
      get :list
    end
    member do
      patch :update_job_status
    end
  end
  
  resources :follows, only: [:create, :destroy]

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    root 'travelplans#home'
  end

  mount Sidekiq::Web => '/sidekiq'
end
