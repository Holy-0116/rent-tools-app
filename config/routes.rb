Rails.application.routes.draw do
  devise_for :users
  
  root 'items#index'
  resources :items
  resources :users, only: [:edit, :show, :update] do
    resources :addresses, only: [:new]
  end
end
