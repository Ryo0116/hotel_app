Rails.application.routes.draw do
  get 'rooms/index'
  get 'rooms/new'
  get 'rooms/create'
  get 'rooms/description'
  get 'rooms/location'
  get 'rooms/update'


  devise_for :users, controllers: {   registrations: 'users/registrations',sessions: 'users/sessions' }
  get 'nomads/top'
  get 'rooms/search'
  get '/users/sign_in'
  get '/users/sign_up'
  get 'rooms/new'
  get 'reservations/show'
  get 'rooms/search'
  get 'rooms/posts' => 'rooms#index'
  get 'users/registrations/edit'
  get 'users/profile' => 'users#profile'
  get '/your_reservations' => 'reservations#your_reservations'

  resource :rooms, only: :show


  resources :rooms, except: [:edit] do
    member do
      get 'rooms/new'
      get 'rooms/posts' => 'rooms#index'
      get 'show'
      get 'description'
      get 'preload'
      get 'preview'
    end
    resources :reservations, only: [:create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
