LogalingServer::Application.routes.draw do
  get "user_glossary/new"

  get "search", :as => :search, :controller => 'search', :action => :index

  get "top/index"

  resources :github_projects,
            :path => 'github',
            :constraints => {:id => %r{[^/]+/[^/]+}},
            :only => [:show, :new, :create] do
    resources :glossaries,
              :constraints => {:id => %r{[^-]+-[^-]+}},
              :only => :show
  end

  match '/auth/:provider/callback', to: 'sessions#create'
  match '/auth/failure', to: 'sessions#failure'
  match "/signout" => "sessions#destroy", :as => :signout
  match "/dashboard" => "dashboard#show", :as => :dashboard
  match "/users/:id/glossaries/new" => "user_glossary#new", :as => :new_user_glossary

  root :to => 'top#index'
end
