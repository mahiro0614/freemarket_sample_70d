Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :users, only: [:index, :new, :create, :destroy, :show] do
    resources :cards, only: [:index, :new, :create, :destroy, :edit, :update]
  end
  resources :items, only: [:new, :create, :destroy, :show, :edit, :update]
  resources :cards, only: [:index, :new]
end
