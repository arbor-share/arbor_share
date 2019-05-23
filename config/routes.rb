Rails.application.routes.draw do
  get '/policy', to: 'policy#index'

  namespace :admin do
    resources :projects, only: [:new, :create]
  end

  resources :projects, only: [:show]
end
