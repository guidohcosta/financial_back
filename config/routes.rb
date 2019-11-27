Rails.application.routes.draw do
  resources :login, only: :create
  resources :transfers, only: :create
end
