A3::Application.routes.draw do
  devise_for :users, :skip => [:sessions, :registrations, :confirmations, :passwords, :unlocks]
  as :user do
    get 'register' => 'registrations#new', :as => :new_user_registration
    post 'register' => 'registrations#create', :as => :user_registration
    get 'cancel' => 'registrations#cancel', :as => :cancel_user_registration
    get 'profile' => 'registrations#edit', :as => :edit_user_registration
    put 'register' => 'registrations#update'
    delete 'register' => 'registrations#destroy'
    get 'reset-password' => 'passwords#new', :as => :new_user_password
    get 'change-password' => 'passwords#edit', :as => :edit_user_password
    post 'password' => 'passwords#create', :as => :user_password
    put 'password' => 'passwords#update'
    get 'confirmation' => 'confirmations#new', :as => :new_user_confirmation
    get 'confirm' => 'confirmations#show'
    post 'confirm' => 'confirmations#create', :as => :user_confirmation
    get 'unlock' => 'unlocks#new', :as => :unlock
    get 'login' => 'sessions#new', :as => :new_user_session
    post 'login' => 'sessions#create', :as => :user_session
    delete 'logout' => 'sessions#destroy', :as => :destroy_user_session
  end

  match '/businesses' => 'businesses#businesses', :as => :businesses
  post '/businesses' => 'businesses#search', :as => :search_businesses
  match '/business/:id' => 'businesses#business', :as => :business
  match '/people' => 'people#people', :as => :people
  match '/person/:id' => 'people#person', :as => :person
  match '/businesses/contribute' => 'contributions#businesses', :as => :contribute_business
  match '/people/contribute' => 'contributions#people', :as => :contribute_person

  namespace :admin do
    match '/' => 'dashboard#index', :as => :dashboard
    resources :users
    resources :articles
    match '/page/:id/publish' => 'pages#publish', :as => :publish_page
    resources :pages
    match '/businesses/:id/approve' => 'businesses#approve', :as => :approve_business
    match '/businesses/addfield' => 'businesses#addfield', :as => :business_addfield
    resources :businesses
    resources :person
    resources :attachments
  end

  match '/blog' => 'posts#articles', :as => :articles
  match '/blog/:id' => 'posts#article', :as => :article
  match '/:name' => 'posts#page', :as => :page
  root :to => 'posts#index'
end
