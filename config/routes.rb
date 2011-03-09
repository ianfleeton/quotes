Quotes::Application.routes.draw do

  root :to => "quotes#index"

  resources :items do
    collection do
      get 'up'
      get 'down'
    end
  end

  resources :categories do
    collection do
      get 'up'
      get 'down'
    end
  end

  resources :quotes do
    member do
      get 'send_or_back'
      get 'preview'
      post 'send_quote'
    end
  end

  resources :profiles

  resources :users


  match 'signup' => 'users#new', :as => :signup

  match 'register' => 'users#create', :as => :register

  match 'login' => 'sessions#new', :as => :login

  match 'logout' => 'sessions#destroy', :as => :logout

  resources :sessions

  match 'forgot_password' => 'users#forgot_password', :as => :forgot_password
  match 'forgot_password_send' => 'users#forgot_password_send', :as => :forgot_password_send
  match 'reset_password' => 'users#forgot_password_new', :as => :reset_password
  match 'forgot_password_change' => 'users#forgot_password_change'

end
