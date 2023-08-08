Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :travels
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :user do#トップページをログイン画面に
    root 'travels#home'
  end
end
