Rails.application.routes.draw do
  root to: 'home#index'
  get 'search', to: 'cards#search'
  resources :cards, only: %i[index show]
  resources :types, only: %i[index show]
  resources :rarities, only: %i[index show]
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
