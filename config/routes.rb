Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  root "items#index"
  resources :items do
    resources :purchases, only: [:index, :create]
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end
  resources :users, only: :new
end
