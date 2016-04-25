Rails.application.routes.draw do
  resources :users
  root 'games#index'
  resources :games
end
