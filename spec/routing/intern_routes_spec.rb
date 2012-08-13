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

  it 'should route POST /intern/appointments/1/accept to the appointment accept action' do
    { :post => '/intern/appointments/1/accept' }.should route_to(
      :controller => 'intern/appointments',
      :action => 'accept',
      :id => '1'
    )
  end

  it 'should route POST /intern/appointments/1/reject to the appointment reject action' do
    { :post => '/intern/appointments/1/reject' }.should route_to(
      :controller => 'intern/appointments',
      :action => 'reject',
      :id => '1'
    )
  end
end
