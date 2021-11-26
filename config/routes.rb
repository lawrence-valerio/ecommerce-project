Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  get 'search', to: 'cards#search'
  resources :cards, only: %i[index show]
  resources :types, only: %i[index show]
  resources :users
  resources :cart, only: %i[index create destroy update]
  resources :rarities, only: %i[index show]

  scope '/checkout' do
    post 'create',  to: 'checkout#create',  as: 'checkout_create'
    get  'success', to: 'checkout#success', as: 'checkout_success'
    get  'cancel',  to: 'checkout#cancel',  as: 'checkout_cancel'
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
