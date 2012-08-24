require 'spec_helper'

describe Intern::AccountsController do
  let(:admin) { FactoryGirl.create :admin }
  let(:user)  { FactoryGirl.create :user }

  describe '#new' do
    it 'should give admins access' do
      sign_in admin
      get :new

      response.should be_success
    end

    it 'should deny normal users access' do
      sign_in user
      get :new

      should redirect_to intern_root_url
      should set_the_flash[:error]
    end
  end

  describe '#create' do
    it 'should give admins access' do
      sign_in admin
      Role.find_or_create_by_name 'Member'
      post :create, :user => { :email => 'test@test.com' }

      should redirect_to new_intern_account_path
    end

    it 'should deny normal users access' do
      sign_in user
      post :create, :user => { :email => 'test@test.com' }

      should redirect_to intern_root_url
      should set_the_flash[:error]
    end
  end

  describe '#update' do
    it 'should return to profile page when update succeeded' do
      sign_in user
      avatar = Rack::Test::UploadedFile.new "#{Rails.root}/features/fixtures/test.png", 'image/png'

      put :update, :user => { :avatar => avatar }, :id => user.id

      should redirect_to intern_profile_path
      should set_the_flash[:success].to /erfolgreich/i
    end
  end
end
