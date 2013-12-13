MusicApp::Application.routes.draw do
  root :to => "users#index"

  resources :users, :except => [:edit, :update, :destroy]
  resource :sessions, :only => [:create, :destroy, :new]

end
