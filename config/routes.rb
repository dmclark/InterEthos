Interethos::Application.routes.draw do
  get "activations/create"

  match '/register' => 'users#create', :as => :register
  resources :categories
  resources :collections
  resources :collections_users
  resources :languages
  resources :relationships
  resources :roles
  resources :posts
  resources :taxonomies
  resources :taxonomies_users
  resources :teams
  resources :teams_users
  resources :topics
  resources :validations
  resources :users
  resources :user_sessions
    match '/activate/:activation_code' => 'activations#create'
    match 'login' => 'user_sessions#new', :as => :login
    match 'logout' => 'user_sessions#destroy', :as => :logout
  root :to => 'welcome#index'
  match '/:controller(/:action(/:id))'
end