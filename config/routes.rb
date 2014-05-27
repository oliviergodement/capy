Rails.application.routes.draw do

  root 'home#index'
  resources :firms
  resources :shareholders, only: [:index, :show, :edit, :update]

  get 'firms/:id/shareholders' => 'shareholders#index', as: :add_shareholders
  post 'firms/:id/shareholders/' => 'shareholders#create', as: :create_shareholder
  delete 'firms/:id/shareholders/:shareholder_id' => 'shareholders#destroy', as: :delete_shareholder
  get 'firms/:id/ownership' => "firms#ownership", as: :ownership
  post 'firms/:id/ownership' => "firms#update_ownership", as: :update_ownership
end