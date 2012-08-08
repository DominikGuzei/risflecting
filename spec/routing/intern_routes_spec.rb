require 'spec_helper'

describe 'Intern' do
  it 'should route GET /intern to the dashboard' do
    { :get => '/intern' }.should route_to(
      :controller => 'intern/dashboards',
      :action => 'show'
    )
  end
end

describe 'Intern::Appointment' do
  it 'should route GET /intern/appointments to the appointment list' do
    { :get => '/intern/appointments' }.should route_to(
      :controller => 'intern/appointments',
      :action => 'index'
    )
  end

  it 'should route GET /intern/appointments/new to the appointment creation form' do
    { :get => '/intern/appointments/new' }.should route_to(
      :controller => 'intern/appointments',
      :action => 'new'
    )
  end

  it 'should route POST /intern/appointments to the appointment create action' do
    { :post => '/intern/appointments' }.should route_to(
      :controller => 'intern/appointments',
      :action => 'create'
    )
  end

  it 'should route POST /intern/appointments/1/attend to the appointment attend action' do
    { :post => '/intern/appointments/1/attend' }.should route_to(
      :controller => 'intern/appointments',
      :action => 'attend',
      :id => '1'
    )
  end
end
