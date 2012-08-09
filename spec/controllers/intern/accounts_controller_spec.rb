require 'spec_helper'

describe Intern::AccountsController do
  describe '#new' do
    it 'should give admins access' do
      sign_in FactoryGirl.create(:admin)
      get :new

      response.should be_success
    end

    it 'should deny normal users access' do
      sign_in FactoryGirl.create(:user)
      get :new

      response.should redirect_to intern_root_url
      flash[:error].should_not be_nil
    end
  end

  describe '#create' do
    it 'should give admins access' do
      Role.find_or_create_by_name 'Member'
      sign_in FactoryGirl.create(:admin)
      post :create, :user => { :email => 'test@test.com' }

      response.should redirect_to new_intern_account_path
    end

    it 'should deny normal users access' do
      sign_in FactoryGirl.create(:user)
      post :create, :user => { :email => 'test@test.com' }

      response.should redirect_to intern_root_url
      flash[:error].should_not be_nil
    end
  end
end
