# encoding: utf-8
require 'spec_helper'

describe Intern::AttachmentsController do
  describe '#create' do
    before :each do
      @user = FactoryGirl.create :user
      sign_in @user
    end

    after(:each) { @user.destroy }

    context Intern::QuestionsController do
      let(:question) { FactoryGirl.create :question }

      it 'should allow the question´s author to create an attachment' do
        question.update_attribute :author, @user
        file = Rack::Test::UploadedFile.new "#{Rails.root}/features/fixtures/test.png", 'image/png'

        post :create, :attachment => { :file => file }, :question_id => question.id

        Attachment.last.attachable.should == question
      end

      it 'should not allow non-authors to create attachments' do
        post :create, :attachment => { }, :question_id => question.id

        should redirect_to intern_root_path
        should set_the_flash[:error]
      end
    end

    context Intern::ProjectsController do
      let(:project) { FactoryGirl.create :project }

      it 'should allow the project´s author to create an attachment' do
        project.update_attribute :author, @user
        file = Rack::Test::UploadedFile.new "#{Rails.root}/features/fixtures/test.png", 'image/png'

        post :create, :attachment => { :file => file }, :project_id => project.id

        Attachment.last.attachable.should == project
      end

      it 'should not allow non-authors to create attachments' do
        post :create, :attachment => { }, :project_id => project.id

        should redirect_to intern_root_path
        should set_the_flash[:error]
      end
    end
  end
end
