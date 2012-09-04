require 'spec_helper'

describe 'Intern' do
  it 'should route GET /intern to the dashboard' do
    { :get => '/intern' }.should route_to(
      :controller => 'intern/dashboards',
      :action => 'show'
    )
  end
end

describe 'Intern::Account' do
  it 'should route GET /intern/benutzer/:id to the account show action' do
    { :get => '/intern/benutzer/1' }.should route_to(
      :controller => 'intern/accounts',
      :action => 'show',
      :id => '1'
    )
  end
end

describe 'Intern::Profile' do
  it 'should route GET /intern/profil to the account show action' do
    { :get => '/intern/profil' }.should route_to(
      :controller => 'intern/accounts',
      :action => 'show'
    )
  end

  it 'should route GET /intern/profil/bearbeiten to the account edit action' do
    { :get => '/intern/profil/bearbeiten' }.should route_to(
      :controller => 'intern/accounts',
      :action => 'edit'
    )
  end

  it 'should route PUT /intern/profil to the account update action' do
    { :put => '/intern/profil' }.should route_to(
      :controller => 'intern/accounts',
      :action => 'update'
    )
  end
end

describe 'Intern::Appointment' do
  it 'should route GET /intern/termine to the appointment list' do
    { :get => '/intern/termine' }.should route_to(
      :controller => 'intern/appointments',
      :action => 'index'
    )
  end

  it 'should route GET /intern/termine/neu to the appointment creation form' do
    { :get => '/intern/termine/neu' }.should route_to(
      :controller => 'intern/appointments',
      :action => 'new'
    )
  end

  it 'should route POST /intern/termine to the appointment create action' do
    { :post => '/intern/termine' }.should route_to(
      :controller => 'intern/appointments',
      :action => 'create'
    )
  end

  it 'should route POST /intern/termine/:id/zusagen to the appointment accept action' do
    { :post => '/intern/termine/1/zusagen' }.should route_to(
      :controller => 'intern/appointments',
      :action => 'accept',
      :id => '1'
    )
  end

  it 'should route POST /intern/termine/:id/absagen to the appointment reject action' do
    { :post => '/intern/termine/1/absagen' }.should route_to(
      :controller => 'intern/appointments',
      :action => 'reject',
      :id => '1'
    )
  end

  it 'should route DELETE /intern/termine/:id to the appointment destroy action' do
    { :delete => '/intern/termine/1' }.should route_to(
      :controller => 'intern/appointments',
      :action => 'destroy',
      :id => '1'
    )
  end
end

describe 'Intern::Questions' do
  it 'should route GET /intern/fragen-und-mitteilungen to the questions list' do
    { :get => '/intern/fragen-und-mitteilungen' }.should route_to(
      :controller => 'intern/questions',
      :action => 'index'
    )
  end

  it 'should route GET /intern/fragen-und-mitteilungen/neu to the question creation form' do
    { :get => '/intern/fragen-und-mitteilungen/neu' }.should route_to(
      :controller => 'intern/questions',
      :action => 'new'
    )
  end

  it 'should route POST /intern/fragen-und-mitteilungen to the question create action' do
    { :post => '/intern/fragen-und-mitteilungen' }.should route_to(
      :controller => 'intern/questions',
      :action => 'create'
    )
  end
end

describe 'Intern::Documents' do
  it 'should route GET /intern/dokumente to the documents list' do
    { :get => '/intern/dokumente' }.should route_to(
      :controller => 'intern/documents',
      :action => 'index'
    )
  end

  it 'should route GET /intern/dokumente/neu to the document creation form' do
    { :get => '/intern/dokumente/neu' }.should route_to(
      :controller => 'intern/documents',
      :action => 'new'
    )
  end

  it 'should route POST /intern/dokumente to the document create action' do
    { :post => '/intern/dokumente' }.should route_to(
      :controller => 'intern/documents',
      :action => 'create'
    )
  end
end

describe 'Intern::Projects' do
  it 'should route GET /intern/tatenbank to the projects list' do
    { :get => '/intern/tatenbank' }.should route_to(
      :controller => 'intern/projects',
      :action => 'index'
    )
  end

  it 'should route GET /intern/tatenbank/neu to the project creation form' do
    { :get => '/intern/tatenbank/neu' }.should route_to(
      :controller => 'intern/projects',
      :action => 'new'
    )
  end

  it 'should route POST /intern/tatenbank to the project create action' do
    { :post => '/intern/tatenbank' }.should route_to(
      :controller => 'intern/projects',
      :action => 'create'
    )
  end
end

describe 'Intern::Attachments' do
  it 'should route POST /intern/tatenbank/:id/anhang to the project attachment create action' do
    { :post => '/intern/tatenbank/1/anhang' }.should route_to(
      :controller => 'intern/attachments',
      :project_id => '1',
      :action => 'create'
    )
  end

  it 'should route POST /intern/fragen-und-mitteilungen/:id/anhang to the question attachment create action' do
    { :post => '/intern/fragen-und-mitteilungen/1/anhang' }.should route_to(
      :controller => 'intern/attachments',
      :question_id => '1',
      :action => 'create'
    )
  end
end

describe 'Intern::Comments' do
  it 'should route POST /intern/fragen-und-mitteilungen/:id/kommentare to the question create action' do
    { :post => '/intern/fragen-und-mitteilungen/1/kommentare' }.should route_to(
      :controller => 'intern/comments',
      :question_id => '1',
      :action => 'create'
    )
  end
end

