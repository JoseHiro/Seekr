Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :users, only: [:show]
  resources :locations, only: [:create, :update]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :businesses do
    resources :products
  end

  resources :itineraries, only: [:new, :update, :delete]
end
