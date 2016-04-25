Rails.application.routes.draw do
  resources :users
  resources :players
  root 'games#index'
  resources :games
end
