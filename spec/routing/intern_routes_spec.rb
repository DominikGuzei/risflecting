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

  it 'should route POST /intern/appointments/:id/accept to the appointment accept action' do
    { :post => '/intern/appointments/1/accept' }.should route_to(
      :controller => 'intern/appointments',
      :action => 'accept',
      :id => '1'
    )
  end

  it 'should route POST /intern/appointments/:id/reject to the appointment reject action' do
    { :post => '/intern/appointments/1/reject' }.should route_to(
      :controller => 'intern/appointments',
      :action => 'reject',
      :id => '1'
    )
  end

  it 'should route DELETE /intern/appointments/:id to the appointment destroy action' do
    { :delete => '/intern/appointments/1' }.should route_to(
      :controller => 'intern/appointments',
      :action => 'destroy',
      :id => '1'
    )
  end
end

describe 'Intern::Posts' do
  it 'should route GET /intern/posts to the posts list' do
    { :get => '/intern/posts' }.should route_to(
      :controller => 'intern/posts',
      :action => 'index'
    )
  end

  it 'should route GET /intern/posts/new to the post creation form' do
    { :get => '/intern/posts/new' }.should route_to(
      :controller => 'intern/posts',
      :action => 'new'
    )
  end

  it 'should route POST /intern/posts to the post create action' do
    { :post => '/intern/posts' }.should route_to(
      :controller => 'intern/posts',
      :action => 'create'
    )
  end
end

describe 'Intern::Comments' do
  it 'should route POST /intern/posts/:id/comments to the post create action' do
    { :post => '/intern/posts/1/comments' }.should route_to(
      :controller => 'intern/comments',
      :post_id => '1',
      :action => 'create'
    )
  end
end

