require 'spec_helper'

describe Intern::ProjectsController do
  describe '#create' do
    before :each do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    after(:each) { @user.destroy }

    it 'should create a project which belongs to the current user' do
      post :create, :project => { :title => 'A test title', :body => 'Some awesome stuff I did' }

      @user.projects.should include Project.last
    end

    it 'should redirect to the project details if creation was successful' do
      post :create, :project => { :title => 'A test title', :body => 'Some awesome stuff I did' }

      should redirect_to intern_project_path Project.last
      should set_the_flash.to(/erfolgreich/i)
    end

    it 'should render the form again if creation failed' do
      post :create, :project => { :title => 'A test title', :body => '' } # :body is required

      should render_template :new
    end
  end
end
