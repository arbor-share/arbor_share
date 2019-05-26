Rails.application.routes.draw do
  root 'projects#index'
  get '/policy', to: 'policy#index'
  get '/auth/:provider/callback', to: 'sessions#create'

  resources :users, only: [:new, :create]


  namespace :admin do
    resources :projects, only: [:new, :create]
  end

  resources :projects, only: [:show, :create]

  namespace :projects do
    post '/:id/carpools/:carpool_id/update', to: 'carpools#update', as: 'carpool_update'
    post '/:id/carpools/create', to: 'carpools#create', as: 'create_carpool'
  end
end
