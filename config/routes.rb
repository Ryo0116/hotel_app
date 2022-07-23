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
  get '/reservations' => 'reservations#index'
  post 'reservations/confirm' # 確認画面


  resource :rooms


  resources :rooms, except: [:edit] do
    member do
      get 'rooms/new'
      get 'rooms/posts' => 'rooms#index'
      get 'description'
      post 'reservations/confirm' # 確認画面
    end

  resources :reservations

  get '/reservations' => 'reservations#index'
  post 'reservations/confirm' # 確認画面
  post 'rreservations/back' # 確認画面から「入力画面に戻る」をクリックしたとき
  post 'reservations/complete' # 完了画面
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
