Risflecting::Application.routes.draw do
  namespace :intern, :path_names => { :new => 'neu', :edit => 'bearbeiten'} do
    devise_for :users,
      :controllers => { :sessions => 'devise/sessions', :registrations => 'devise/registrations', :passwords => 'devise/passwords' },
      :path => '', :path_names => { :sign_in => 'anmelden', :sign_out => 'abmelden', :password => 'passwort', :confirmation => 'registrieren' }

    devise_scope :intern_user do
      put '/user/confirm' => 'confirmations#confirm', :path => 'registrieren'
    end

    resource :dashboard, :only => [:show], :path => 'aktuelles'
    resource :profile, :only => [:show, :edit, :update], :controller => :accounts, :path => 'profil'
    resources :accounts, :only => [:create, :new, :show], :path => 'benutzer', :path_names => { :new => 'einladen' }
    resources :documents, :except => [:edit, :update], :path => 'dokumente'

    resources :questions, :except => [:destroy], :path => 'fragen-und-mitteilungen' do
      resources :comments, :only => [:create], :path => 'kommentare'
      resources :attachments, :only => [:create, :destroy], :path => 'anhang'
    end

    resources :appointments, :path => 'termine', :path_names => { :accept => 'zusagen', :reject => 'absagen' } do
      post :accept, :on => :member
      post :reject, :on => :member
    end

    resources :projects, :except => [:destroy], :path => 'tatenbank' do
      resources :attachments, :only => [:create, :destroy], :path => 'anhang'
    end

    root :to => 'dashboards#show'
  end

  # Routes for external website
  match '/*id' => 'high_voltage/pages#show', :as => :static, :via => :get
  root :to => 'high_voltage/pages#show', :id => 'willkommen'
end
