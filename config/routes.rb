LogalingServer::Application.routes.draw do
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

  resources :users, :only => [] do
    resources :github_project_memberships,
      :only => [:new, :create]
    resources :user_glossaries,
      :path => 'glossaries',
      :only => [:new, :create, :show],
      :as => :glossaries do
        resources :terms
    end
  end

  match '/auth/:provider/callback', to: 'sessions#create'
  match '/auth/failure', to: 'sessions#failure'
  match "/signout" => "sessions#destroy", :as => :signout
  match "/dashboard" => "dashboard#show", :as => :dashboard

  root :to => 'top#index'
end
