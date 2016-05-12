Rails.application.routes.draw do
  root 'homepage#index'
  get 'homepage/index'

  resources :users
  resources :games, only: [:index, :show, :new, :create, :destroy] do
    resources :players, only: [:index, :new, :create]
    resources :dice_rolls, only: [:create]
  end
end
