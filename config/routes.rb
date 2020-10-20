Rails.application.routes.draw do
  get 'cards/new'
  devise_for :users
  root 'items#index'
  resources :items do
    resource :order do
      collection do
        get :select_card
        post :set_default_card
      end
    end
  end
  resources :users, only: [:edit, :show, :update] do
    resource :address, only: [:new, :create, :edit, :update]
    resource :card, only: [:new, :create, :show]
  end
end
