Rails.application.routes.draw do
  get 'errors/not_found'
  get 'errors/internal_server_error'
  devise_for :users
  root "main#index"
  match "about", to: "main#about", via: :get
  match "admin/organizations/:id", to: "organizations#admin", via: :get
  match "admin", to: "admin#index", via: :get
  match "beta", to: "beta#index", via: :get
  match "admin/grant/:id", to: "admin#grant", via: :post
  match "admin/revoke/:id", to: "admin#revoke", via: :post
  match "admin/organizations/grant/:id", to: "admin#org_grant", via: :post
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
  
  resources :users

  resources :organizations do
    member do
      get :delete
    end
  end

  resources :memberships

  get 'main/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
