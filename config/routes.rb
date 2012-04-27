A3::Application.routes.draw do
  devise_for :users, :skip => [:sessions, :registrations, :confirmations, :passwords, :unlocks], :controllers => {:omniauth_callbacks => 'users'}
  as :user do
    get 'auth/:provider' => 'users#omniauth', :as => :user_omniauth_authorize
    get 'linkedin-callback' => 'users#linkedin', :as => :linkedin_callback
    get 'register' => 'registrations#new', :as => :new_user_registration
    get 'register/:linkedin_id(/:security_string)' => 'users#newlinkedin', :as => :linkedin_registration
    put 'register/:linkedin_id(/:security_string)' => 'users#createlinkedin'
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

  match '/success/:type' => 'posts#success', :as => :success
  match '/businesses' => 'businesses#businesses', :as => :businesses
  post '/businesses' => 'businesses#search', :as => :search_businesses
  match '/business/:id' => 'businesses#business', :as => :business
  match '/people' => 'people#people', :as => :people
  match '/person/:id' => 'people#person', :as => :person
  match '/businesses/contribute' => 'contributions#business', :as => :contribute_business
  post '/businesses/contribute' => 'contributions#contribiz'
  match '/people/contribute' => 'contributions#people', :as => :contribute_person

  namespace :admin do
    match '/' => 'dashboard#index', :as => :dashboard
    match '/users/:id/ban' => 'users#ban', :as => :ban_user
    resources :users
    match '/article/:id/publish' => 'articles#publish', :as => :publish_article
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
  match '/blog/c' => 'posts#categories', :as => :categories
  match '/blog/c/:name' => 'posts#category', :as => :category
  match '/blog/:id' => 'posts#article', :as => :article
  match '/:name' => 'posts#page', :as => :page
  root :to => 'posts#index'
end
