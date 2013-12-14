MusicApp::Application.routes.draw do
  root :to => "users#index"

  resources :users, :except => [:edit, :update, :destroy] do
    collection do
      get "/not_activated", :to => "users#not_activated"
      get "/activate", :to => "users#activate"
    end
  end


  resource :sessions, :only => [:create, :destroy, :new]

  resources :bands do
    resources :albums, :only => [:new, :create]
  end

  resources :albums, :only => [:index, :show, :edit, :update, :destroy] do
    resources :tracks, :only => [:new, :create]
  end

  resources :tracks, :only => [:index, :show, :edit, :update, :destroy] do
    resources :notes, :only => [:create, :destroy]
  end

end
