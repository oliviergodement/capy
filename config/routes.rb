Rails.application.routes.draw do

  root 'home#index', as: :home

  devise_for :users
  ActiveAdmin.routes(self)

  resources :firms
  get 'firms/:id/round/:round_id/ownership' => "firms#ownership", as: :ownership
  post 'firms/:id/round/:round_id/ownership' => "firms#update_ownership", as: :update_ownership
  get 'firms/:id/cap_table' => "firms#cap_table", as: :cap_table

  resources :shareholders, only: [:show, :edit, :update]
  get 'firms/:id/round/:round_id/shareholders' => 'shareholders#new', as: :new_shareholder
  post 'firms/:id/round/:round_id/shareholders/' => 'shareholders#create', as: :create_shareholder
  delete 'firms/:id/round/:round_id/shareholders/:shareholder_id' => 'shareholders#destroy', as: :delete_shareholder

  resources :rounds, only: [:edit, :update, :destroy]
  get 'firms/:id/rounds/new' => 'rounds#new', as: :new_round
  get 'firm/:id/round/:round_id' => 'rounds#show', as: :show_round
  post 'firm/:id/rounds' => 'rounds#create', as: :create_round
  get 'firms/:id/rounds' => 'rounds#index', as: :rounds

  get 'firms/:id/round/:round_id/subscription_forms' => 'subscription_forms#index', as: :subscription_forms
  get 'firms/:id/round/:round_id/subscription_form/:shareholder_id/:investment_id' => 'subscription_forms#show', as: :subscription_form

end
