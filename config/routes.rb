Rails.application.routes.draw do
  get 'cards/new'
  devise_for :users
  root 'items#index'
  resources :items
  resources :users, only: [:edit, :show, :update] do
    resource :address, only: [:new, :create, :edit, :update]
    resource :card, only: [:new, :create, :show]
  end
end
