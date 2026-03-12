Rails.application.routes.draw do
  get "/dashboard", to: "dashboard#index"
  root "home#index"

  get "/register", to: "users#new"
  post "/users", to: "users#create"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/dashboard", to: "dashboard#index"

end
