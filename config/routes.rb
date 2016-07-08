Rails.application.routes.draw do
  devise_for :users
  root "comics#index"
  resources :comics, only: [:index, :show]
  # resources :users, only: :show
  resources :sites, only: [:index, :show]
  resources :users, only: :show do
    resources :favorites, only: [:create, :destroy]
  end
  # get "favorites/:user_id/:comic_id" => "favorites#create"
  # delete "/:user_id/:comic_id" => "favorites#destroy"
end