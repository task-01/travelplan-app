Rails.application.routes.draw do
  get 'travels/index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :user do#トップページをログイン画面に
    root 'travels#home'
  end
end
