Rails.application.routes.draw do
  root 'projects#index'
  get '/policy', to: 'policy#index'
  get '/auth/:provider/callback', to: 'sessions#create'

  resources :users, only: [:new, :create]


  namespace :admin do
    resources :projects, only: [:new, :create]
  end

  resources :projects, only: [:show]
end
