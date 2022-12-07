Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :users, only: [:show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :businesses do
    resources :products
  end


  get "/products", to: "products#list_all"
  get "/products/:id", to: "product#show_selected"

  resources :itineraries, only: [:new, :update, :delete]

end
