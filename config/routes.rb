Rails.application.routes.draw do

  root to: "pages#home"
  get "home", to: "pages#home"

  resources :journals do
    member do
      patch :toggle_approval, to: "journals/toggle_approvals#update"
    end
  end
  resources :academics
  get "/sign_up" => "academics#new", as: "sign_up"

  # Clearance Specific routes
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  # get "/sign_up" => "clearance/users#new", as: "sign_up"
end
