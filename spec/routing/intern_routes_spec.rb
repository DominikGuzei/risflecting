require 'spec_helper'

describe 'Intern' do
  it 'should route GET /intern to the dashboard' do
    { :get => '/intern' }.should route_to(
      :controller => 'intern/dashboards',
      :action => 'show'
    )
  end
end

describe 'Intern:Accounts' do
  it 'should route GET /intern/profile to the account show action' do
    { :get => '/intern/profile' }.should route_to(
      :controller => 'intern/accounts',
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

describe 'Intern::Questions' do
  it 'should route GET /intern/questions to the questions list' do
    { :get => '/intern/questions' }.should route_to(
      :controller => 'intern/questions',
      :action => 'index'
    )
  end

  it 'should route GET /intern/questions/new to the question creation form' do
    { :get => '/intern/questions/new' }.should route_to(
      :controller => 'intern/questions',
      :action => 'new'
    )
  end

  it 'should route POST /intern/questions to the question create action' do
    { :post => '/intern/questions' }.should route_to(
      :controller => 'intern/questions',
      :action => 'create'
    )
  end
end

describe 'Intern::Projects' do
  it 'should route GET /intern/projects to the projects list' do
    { :get => '/intern/projects' }.should route_to(
      :controller => 'intern/projects',
      :action => 'index'
    )
  end

  it 'should route GET /intern/projects/new to the project creation form' do
    { :get => '/intern/projects/new' }.should route_to(
      :controller => 'intern/projects',
      :action => 'new'
    )
  end

  it 'should route POST /intern/projects to the project create action' do
    { :post => '/intern/projects' }.should route_to(
      :controller => 'intern/projects',
      :action => 'create'
    )
  end
end

describe 'Intern::Attachments' do
  it 'should route POST /intern/projects/:id/attachments to the project attachment create action' do
    { :post => '/intern/projects/1/attachments' }.should route_to(
      :controller => 'intern/attachments',
      :project_id => '1',
      :action => 'create'
    )
  end

  it 'should route POST /intern/questions/:id/attachments to the question attachment create action' do
    { :post => '/intern/questions/1/attachments' }.should route_to(
      :controller => 'intern/attachments',
      :question_id => '1',
      :action => 'create'
    )
  end
end

describe 'Intern::Comments' do
  it 'should route POST /intern/questions/:id/comments to the question create action' do
    { :post => '/intern/questions/1/comments' }.should route_to(
      :controller => 'intern/comments',
      :question_id => '1',
      :action => 'create'
    )
  end
end

