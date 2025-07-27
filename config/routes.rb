Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: 'users/sessions'
  }
  get 'home', to: 'pages#home'
  get 'about', to: 'pages#about'

  resources :polls

  root 'pages#home'
end
