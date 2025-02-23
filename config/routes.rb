Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }
  resources :meetings
  get "attendances/create"
  get "attendances/destroy"
  get "meetings/index"
  get "meetings/show"
  get "meetings/new"
  get "meetings/create"
  get "meetings/edit"
  get "meetings/update"
  get "meetings/destroy"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :meetings do
    resources :attendances, only: [ :create ]
  end


  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root to: "meetings#index"

  mount ActionCable.server => "/cable"
end
