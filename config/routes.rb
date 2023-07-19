Rails.application.routes.draw do
  root 'articles#index'
  

  resources :articles # provê todas as urls do crud. Ex get '/articles', to: 'articles#index' e et '/articles/:id', to: 'articles#show' Aula_5
end
