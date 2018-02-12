Rails.application.routes.draw do
  root to: "journals#index"

  resources :journals, only: :index
  get "/sign_up" => "academics#new", as: "sign_up"
  resources :academics
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
