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
    collection do
      get 'send_or_back'
      get 'preview'
      post 'send_quote'
    end
  end

  resources :profiles

end
