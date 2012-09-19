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
    resources :user_glossaries,
      :path => 'glossaries',
      :only => [:new, :create, :show],
      :as => :glossaries do
      resources :terms,
        :path => 'terms',
        :as => :terms,
        :only => [:new, :create] do
        collection do
          delete "destroy"
          post "edit"
          put "update"
        end
      end
    end
  end

  match '/auth/:provider/callback', to: 'sessions#create'
  match '/auth/failure', to: 'sessions#failure'
  match "/signout" => "sessions#destroy", :as => :signout
  match "/dashboard" => "dashboard#show", :as => :dashboard

  root :to => 'top#index'
end
