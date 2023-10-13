Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index show] do
        resources :posts, only: %i[index show] do
          resources :comments, only: %i[create new destroy]
          resources :likes, only: %i[create new]
        end
      end
    end
  end


  root 'users#index'

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create destroy] do
      resources :comments, only: %i[new create destroy]
      resources :likes, only: %i[new create]
    end
  end
end
