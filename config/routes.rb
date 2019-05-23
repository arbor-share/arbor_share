Rails.application.routes.draw do
  get '/', to: 'welcome#index'
  get '/policy', to: 'policy#index'
  get '/auth/:provider/callback', to: 'sessions#create'

  resources :users, only: [:new, :create]
end
