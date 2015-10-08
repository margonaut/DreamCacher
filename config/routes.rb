Rails.application.routes.draw do
  root 'homes#index'

  resources :dreams, only: [:index, :create, :new, :update, :edit, :destroy]

  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :dreams, only: [:index, :show]
    end
  end
end
