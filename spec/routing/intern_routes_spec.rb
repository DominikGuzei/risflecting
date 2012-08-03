require 'spec_helper'

describe 'Intern' do
  it 'should route GET /intern to the dashboard' do
    { :get => '/intern' }.should route_to(
      :controller => 'intern/dashboards',
      :action => 'show'
    )
  end
end
