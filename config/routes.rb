Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: 'users/sessions'
  }
  namespace :admin do
    resources :users do
      collection do
        post :import
      end
    end
    resources :polls do
      member do
        get :analytic
      end
    end
  end
  get 'home', to: 'pages#home'
  get 'about', to: 'pages#about'

  resources :polls, only: [:show] do
    member do
      post :vote
    end
  end

  root 'pages#home'
end
