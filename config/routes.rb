Rails.application.routes.draw do
  get 'cards/new'
  devise_for :users
  root 'items#index'
  resources :items
  resources :users, only: [:edit, :show, :update] do
    resources :addresses, only: [:new, :create, :edit, :update]
    resources :cards, only: [:new, :create]
  end
end
