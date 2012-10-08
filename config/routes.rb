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

  resources :users, :only => [:create] do
    resources :github_project_memberships,
      :only => [:new, :create, :destroy]
    resources :user_glossaries,
      :path => 'glossaries',
      :constraints => {:id => %r{[^/]+/[^/]+}},
      :only => [:new, :create, :show, :destroy],
      :as => :glossaries do
        resources :terms,
          :constraints => {:id => %r{[^/]+}, :glossary_id => %r{[^/]+/[^/]+}}
    end
    resources :user_configs,
      :path => 'configs',
      :as => :configs
  end

  match '/auth/:provider/callback', to: 'sessions#create'
  match '/auth/failure', to: 'sessions#failure'
  match '/signup' => 'users#new', as: :signup
  match '/signin' => 'sessions#new', as: :signin
  match "/signout" => "sessions#destroy", :as => :signout
  match "/dashboard" => "dashboard#show", :as => :dashboard

  root :to => 'top#index'
end
