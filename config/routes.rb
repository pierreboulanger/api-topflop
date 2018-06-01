Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :teams do
        resources :users
        resources :games do
          resources :top, only: [:new, :create, :edit, :update]
          resources :flop, only: [:new, :create, :edit, :update]
        end
      end
    end
  end
end
