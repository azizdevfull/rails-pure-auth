Rails.application.routes.draw do
  # get 'home/index'
  root "home#index"

  get "register", to: "users#new"
  post "users", to: "users#create"

  get "login", to: "users#login"
  post "authenticate", to: "users#authenticate"
  
  delete "logout", to: "users#logout"
  resources :users do
    post :authenticate, on: :collection
  end
end
