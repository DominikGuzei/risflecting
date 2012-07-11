Risflecting::Application.routes.draw do
  match '/:id' => 'high_voltage/pages#show', :as => :static, :via => :get

  root :to => 'high_voltage/pages#show', :id => 'willkommen'
end
