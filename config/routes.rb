Risflecting::Application.routes.draw do
  namespace :intern do
    devise_for :users, :controllers => { :sessions => 'intern/sessions' }

    resource :dashboard, :only => [:show]
    resources :appointments, :only => [:new, :create, :show, :index]
    resources :accounts, :only => [ :create, :new ]
  end

    root :to => 'dashboards#show'
  end

  # Routes for external website

  match '/*id' => 'high_voltage/pages#show', :as => :static, :via => :get

  root :to => 'high_voltage/pages#show', :id => 'willkommen'
end
