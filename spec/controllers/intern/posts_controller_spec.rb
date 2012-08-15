require 'spec_helper'

describe Intern::PostsController do
  describe '#create' do
    before :each do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    after(:each) { @user.destroy }

    it 'should create a post which belongs to the current user' do
      post :create, :post => { :title => 'A test title', :body => 'Some problems and questions' }

      @user.posts.should include Post.last
    end

    it 'should redirect to the post details if creation was successful' do
      post :create, :post => { :title => 'A test title', :body => 'Some problems and questions' }

      should redirect_to intern_post_path Post.last
      should set_the_flash.to(/erfolgreich/i)
    end

    it 'should render the form again if creation failed' do
      post :create, :post => { :title => 'A test title', :body => '' } # :body is required

      should render_template :new
    end
  end
end
