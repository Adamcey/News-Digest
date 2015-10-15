Rails.application.routes.draw do

  root 'sessions#home'

  get 'sessions/home', as: :home
  post 'sessions/login', as: :login
  delete 'sessions/logout', as: :logout

  get 'users/emailMyself', to: 'users#emailMyself', as: :requestArticles

  get 'articles/index', to: 'articles#interests', as: :interests
  get 'articles/scrape', to: 'articles#scrape', as: :scrape

  resources :users
  resources :articles

end
