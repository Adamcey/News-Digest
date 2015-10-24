Rails.application.routes.draw do

  root 'sessions#home'

  get 'sessions/home', as: :home
  post 'sessions/login', as: :login
  delete 'sessions/logout', as: :logout

  get 'users/emailMyself', to: 'users#emailMyself', as: :requestArticles
  get 'users/subscribe', to: 'users#subscribe', as: :subscribe

  get 'articles/interests', to: 'articles#interests', as: :interests
  get 'articles/scrape', to: 'articles#scrape', as: :scrape
  post 'articles/search', to: 'articles#search', as: :search

  get 'admin/email', to: 'admin#sendEmailToSubscribers', as: :sendEmails
  get 'admin/scrape', to: 'admin#scrape', as: :scrapeArticles

  resources :users
  resources :articles

end
