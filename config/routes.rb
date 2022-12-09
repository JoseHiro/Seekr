Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :users, only: [:show]
  resources :locations, only: [:create, :update]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :businesses do
    resources :products
  end

  get "/products", to: "products#list_all"
  get "/products/:id", to: "products#show_selected", as: "product_show"

  resources :itineraries, only: [:new, :update]
  get "/itineraries/:product_id/generate", to: "itineraries#create", as: "create_itinerary"
  get "/my_itineraries", to: "itineraries#index", as: "my_itinerary"
  get "/my_itineraries/:id", to: "itineraries#show", as: "my_itineraries"
  patch "/my_itineraries/:id/update/:element", to: "itineraries#update_element", as: "update_element"
end
