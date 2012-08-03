require 'spec_helper'

describe 'Intern' do
  it 'routes GET /intern/ to the dashboard (internal website)' do
    { :get => '/intern' }.should route_to(
      :controller => 'intern/dashboards',
      :action => 'show'
    )
  end
end
