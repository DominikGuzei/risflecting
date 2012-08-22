require 'spec_helper'

describe Intern::QuestionsController do
  describe '#create' do
    before :each do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    after(:each) { @user.destroy }

    it 'should create a question which belongs to the current user' do
      post :create, :question => { :title => 'A test title', :body => 'Some problems and questions' }

      @user.questions.should include Question.last
    end

    it 'should redirect to the question details if creation was successful' do
      post :create, :question => { :title => 'A test title', :body => 'Some problems and questions' }

      should redirect_to intern_question_path Question.last
      should set_the_flash.to(/erfolgreich/i)
    end

    it 'should render the form again if creation failed' do
      post :create, :question => { :title => 'A test title', :body => '' } # :body is required

      should render_template :new
    end
  end
end
