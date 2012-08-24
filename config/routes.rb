Risflecting::Application.routes.draw do
  namespace :intern do
    devise_for :users, :controllers => { :sessions => 'devise/sessions', :registrations => 'devise/registrations', :passwords => 'devise/passwords' }

    devise_scope :intern_user do
      put '/user/confirm' => 'confirmations#confirm'
    end

    resource :dashboard, :only => [:show]
    resources :accounts, :only => [:create, :new]
    resource :profile, :only => [:show, :edit, :update], :controller => :accounts

    resources :questions, :only => [:index, :show, :new, :create] do
      resources :comments, :only => [:create]
      resources :attachments, :only => [:create]
    end

    resources :appointments, :except => [:edit, :update] do
      post :accept, :on => :member
      post :reject, :on => :member
    end
    resources :projects, :only => [:new, :create, :index, :show] do
      resources :attachments, :only => [:create]
    end

    root :to => 'dashboards#show'
  end

  # Routes for external website
  match '/*id' => 'high_voltage/pages#show', :as => :static, :via => :get
  root :to => 'high_voltage/pages#show', :id => 'willkommen'
end
