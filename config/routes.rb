Rails.application.routes.draw do
  get 'user_itineraries/index'
  get 'user_itineraries/show'
  get 'user_itineraries/create'
  get 'user_itineraries/new'
  get 'user_itineraries/edit'
  get 'user_itineraries/update'
  get 'user_itineraries/destroy'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, except: [:index] do
    resources :user_itineraries
  end
  resources :events, only: [:index, :show]
end
