Rails.application.routes.draw do
  get 'user_categories/index'
  get 'user_categories/show'
  get 'user_categories/create'
  get 'user_categories/destroy'
  devise_for :users
  root to: 'pages#home'
  resources :categories, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, except: [:index]
  resources :itineraries, only: [:index, :new, :show, :create] do
    resources :events, only: :show
  end
end
