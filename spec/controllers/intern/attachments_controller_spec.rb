require 'spec_helper'

describe Intern::AttachmentsController do
  describe '#create' do
    before :each do
      @user = FactoryGirl.create :user
      sign_in @user

      @question = FactoryGirl.create :question
    end

    after(:each) { @user.destroy }

    it 'should create an attachment' do
      @question.update_attribute :author, @user
      file = Rack::Test::UploadedFile.new "#{Rails.root}/features/fixtures/test.png", 'image/png'

      post :create, :attachment => { :file => file }, :question_id => @question.id

      last_attachment = Attachment.last
      last_attachment.attachable.should == @question
    end

    it 'should only allow the author to create attachments' do
      post :create, :attachment => { }, :question_id => @question.id

      should redirect_to intern_root_path
      should set_the_flash[:error]
    end
  end
end
