Rails.application.routes.draw do
  resources :users
  resources :players
  resources :pieces
  root 'games#index'
  resources :games
end
