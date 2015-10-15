Rails.application.routes.draw do
  authenticated do
    root to: 'dreams#index', as: :authenticated
  end
  root to: 'homes#index'

  resources :dreams, only: [:index, :create, :new, :update, :edit, :destroy]

  resources :analytics, only: [:index]

  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :dreams, only: [:index, :show]
      resource :analytics_dashboard, only: [:show]
    end
  end
end
