Rails.application.routes.draw do
  root 'projects#index'
  get '/policy', to: 'policy#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users, only: [:new, :create]


  namespace :admin do
    resources :projects, only: [:new, :create, :show, :edit, :update, :destroy]
    get '/dashboard', to: 'projects#index'
  end

  resources :projects, only: [:show]
end
