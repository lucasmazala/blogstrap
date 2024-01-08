Rails.application.routes.draw do
  scope '(:locale)', locale: /pt-BR|en/ do  # todas as rotas estão dentro do scope aula23 14min
    devise_for :users  

    root 'articles#index'
    #resources :articles # provê todas as urls do crud. Ex get '/articles', to: 'articles#index' e et '/articles/:id', to: 'articles#show' Aula_5
    resources :articles do 
      resources :comments, only: %i[create destroy] # para criar os comentários dentro de articles. Aula 19 12 min
    end

    resources :categories, except: [:show] #aula 13 - 1:03 min Não vamos utilizar show em categorias. 
  end

end
