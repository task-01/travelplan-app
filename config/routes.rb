Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }
  get 'travelplans/:id', to: 'travelplans#home', as: 'travelplans_home'
  resources :travelplans
  resources :users, only: [:show]

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    root 'travelplans#home'
  end
end
