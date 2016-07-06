Rails.application.routes.draw do
  devise_for :users
  root "comics#index"
  resources :comics, only: [:index, :show]
  resources :users, only: :show
  resources :sites, only: [:index, :show]
end
