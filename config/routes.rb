Risflecting::Application.routes.draw do

  namespace :intern do
    resource :dashboard, :only => [:show]
    resources :appointments, :only => [:new, :create, :show, :index]

    root :to => 'dashboards#show'
  end

  match '/*id' => 'high_voltage/pages#show', :as => :static, :via => :get

  root :to => 'high_voltage/pages#show', :id => 'willkommen'
end
