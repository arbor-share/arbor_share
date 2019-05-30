Rails.application.routes.draw do
  root 'projects#index'
  get '/policy', to: 'policy#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users, only: [:new, :create] do
    resources :addresses, only: [:create, :update]
    resources :vehicles, only: [:create, :update]
  end

  namespace :profile do
    get '/', to: 'profile#show'
    get '/edit', to: 'profile#edit'
  end

  namespace :admin do
    resources :projects, only: [:new, :create, :show, :edit, :update, :destroy]
    get '/dashboard', to: 'projects#index'
  end

  resources :projects, only: [:show, :create]

  namespace :projects do
    post '/:id/carpools/:carpool_id/update', to: 'carpools#update', as: 'carpool_update'
    post '/:id/carpools/create', to: 'carpools#create', as: 'create_carpool'
  end

  resources :carpools, only: [:show]
  delete 'projects/:id/carpools/:carpool_id/delete', to: 'projects/carpools/drivers#destroy', as: 'destroy_carpool'
end
