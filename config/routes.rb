Rails.application.routes.draw do
  get '/policy', to: 'policy#index'
  root 'projects#index'
end
