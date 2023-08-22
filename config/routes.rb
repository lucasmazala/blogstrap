Rails.application.routes.draw do
  root 'articles#index'
  resources :articles # provê todas as urls do crud. Ex get '/articles', to: 'articles#index' e et '/articles/:id', to: 'articles#show' Aula_5
  resources :categories, except: [:show] #aula 13 - 1:03 min Não vamos utilizar show em categorias. 
end
