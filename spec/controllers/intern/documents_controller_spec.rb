require 'spec_helper'

describe Intern::DocumentsController do
  describe '#create' do
    context 'as an coordinator' do
      before :each do
        @user = FactoryGirl.create :coordinator
        sign_in @user
      end

      it 'should create a new document if required params are passed' do
        file = Rack::Test::UploadedFile.new "#{Rails.root}/features/fixtures/test.png", 'image/png'
        post :create, :document => { :title => 'Named document', :asset => file }

        should redirect_to intern_documents_path
        should set_the_flash[:success]
        @user.documents.should include Document.last
      end

      it 'should render the form if valdiation failed' do
        post :create, :document => {}

        should render_template :new
      end
    end

    context 'as a normal user' do
      it 'should deny access' do
        sign_in FactoryGirl.create(:user)
        post :create

        should set_the_flash[:error]
        should redirect_to intern_root_url
      end
    end
  end
end
