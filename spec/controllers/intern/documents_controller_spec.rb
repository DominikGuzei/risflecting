require 'spec_helper'

describe Intern::DocumentsController do
  before :each do
    @user = FactoryGirl.create :user
    sign_in @user
  end

  describe '#create' do
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
end
