Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "/owner", to: "pages#owner"

  resources :users, only: [:show]
  resources :locations, only: [:create, :update]


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :businesses do
    resources :products
  end

  post "/businesses", to: "business#create", as: "post_business"

  get "/products", to: "products#list_all"
  get "/products/:id", to: "products#show_selected", as: "product_show"

  resources :itineraries, only: [:new, :update]
  get "/itineraries/:product_id/generate", to: "itineraries#create", as: "create_itinerary"
  get "/my_itineraries", to: "itineraries#index", as: "my_itinerary"
  get "/my_itineraries/:id", to: "itineraries#show", as: "my_itineraries"
  get "/my_itineraries/:id/add_products", to: "itineraries#add_products", as: "add_products"
  patch "/my_itineraries/:id/update/:element", to: "itineraries#update_element", as: "update_element"
  post "my_itineraries/product/:product_id/:itinerary_id/add", to: "itineraries#add_product_to_itinerary", as: "add_product_to_itinerary"
  delete "my_itineraries/product/:product_id/:itinerary_id/remove", to: "itineraries#remove_product_of_itinerary", as: "remove_product_of_itinerary"
  get "my_itineraries/:itinerary_id/get_itinerary", to: "itineraries#itinerary_route", as: "itinerary_route"
  get "my_itineraries/:id/add_stop/new", to: "stops#new", as: "itinerary_stops"
  post "my_itineraries/:id/add_stop/new", to: "stops#create", as: "itinerary_stops_create"
  patch "my_itineraries/:id/completed", to: "itineraries#mark_itinerary_as_completed", as: "mark_as_complete"
  get "history", to:"itineraries#history_itineraries", as: "history_itineraries"
  patch ":id/undo_and_set_current", to: "itineraries#undo_and_set_as_current", as: "undo_and_set_as_current"
  patch ":id/set_as_current", to: "itineraries#set_as_current", as: "set_as_current"
  patch ":id/remove_as_current", to: "itineraries#remove_as_current", as: "remove_as_current"
end
