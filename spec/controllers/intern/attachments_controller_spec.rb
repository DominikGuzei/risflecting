require 'spec_helper'

describe Intern::AttachmentsController do
  describe '#create' do
    before :each do
      @user = FactoryGirl.create :user
      sign_in @user

      @post_instance = FactoryGirl.create :post
    end

    after(:each) { @user.destroy }

    it 'should create an attachment' do
      @post_instance.author = @user
      @post_instance.save
      file = Rack::Test::UploadedFile.new "#{Rails.root}/features/fixtures/test.png", 'image/png'

      post :create, :attachment => { :file => file }, :post_id => @post_instance.id

      last_attachment = Attachment.last
      last_attachment.attachable.should == @post_instance
    end

    it 'should only allow the author to create attachments' do
      post :create, :attachment => { }, :post_id => @post_instance.id

      should redirect_to intern_root_path
      should set_the_flash[:error]
    end
  end
end
