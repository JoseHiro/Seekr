Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :users, only: [:show]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :businesses do
    resources :products
  end

  get "/products", to: "products#list_all"
  get "/products/:id", to: "product#show_selected"

  resources :itineraries, only: [:new]
  get "/itineraries/:product_id/generate", to: "itineraries#create", as: "create_itinerary"
  get "/my_itineraries", to: "itineraries#index", as: "my_itinerary"
  get "/my_itineraries/:id", to: "itineraries#show", as: "my_itineraries"
end
