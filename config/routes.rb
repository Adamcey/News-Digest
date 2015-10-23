Rails.application.routes.draw do

  root 'sessions#home'

  get 'sessions/home', as: :home
  post 'sessions/login', as: :login
  delete 'sessions/logout', as: :logout

  get 'users/emailMyself', to: 'users#emailMyself', as: :requestArticles
  get 'users/subscribe', to: 'users#subscribe', as: :subscribe

  get 'articles/index', to: 'articles#interests', as: :interests
  get 'articles/scrape', to: 'articles#scrape', as: :scrape

  get 'admin/email', to: 'admin#sendEmailToSubscribers', as: :sendEmails

  resources :users
  resources :articles

end
