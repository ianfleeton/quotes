Quotes::Application.routes.draw do
  root "quotes#index"

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


  get 'signup' => 'users#new', as: :signup

  post 'register' => 'users#create', as: :register

  get 'login' => 'sessions#new', as: :login

  post 'logout' => 'sessions#destroy', as: :logout

  resources :sessions

  get 'forgot_password' => 'users#forgot_password', as: :forgot_password
  post 'forgot_password_send' => 'users#forgot_password_send', as: :forgot_password_send
  get 'reset_password' => 'users#forgot_password_new', as: :reset_password
  post 'forgot_password_change' => 'users#forgot_password_change'

end
