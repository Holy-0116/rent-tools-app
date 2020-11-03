Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  resources :items do
    resource :order do
      collection do
        get :select_card
        post :set_default_card
        get :new_address
        post :set_address
        get :edit_address
        patch :update_address
        get :new_card
        post :create_card
      end
    end
  end
  get 'search/keyword'
  get 'search/sort_order'
  resources :users, only: [:edit, :show, :update] do
    resource :address, only: [:new, :create, :edit, :update]
    resource :card, only: [:new, :create, :show]
  end
end
