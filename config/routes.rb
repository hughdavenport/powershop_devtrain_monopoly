Rails.application.routes.draw do
  root 'homepage#index'

  resources :users
  resources :games, only: [:index, :show, :new, :create, :destroy] do
    # TODO integrate into game view instead?
    resources :players, only: [:index, :new, :create]
    resources :dice_rolls, only: [:create]
    resources :property_purchases, only: [:create]
    resources :house_purchases, only: [:create]
    resources :turn_ends, only: [:create]
    # TESTING ROUTE
    resources :set_balances, only: [:create]
  end
end
