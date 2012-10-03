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

  describe '#update' do
    before(:each)  { sign_in FactoryGirl.create(:user) }
    let(:question) { FactoryGirl.create(:question) }

    it 'should update the question with the passed parameters' do
      changed_question = { :title => 'A changed title', :body => 'A changed body' }

      put :update, :id => question.id, :question => changed_question

      updated_question = Question.find question.id
      updated_question.title.should == changed_question[:title]
      updated_question.body.should == changed_question[:body]
    end

    it 'should redirect to the question details page if update was successful' do
      put :update, :id => question.id, :question => { :title => 'A changed title', :body => 'A changed body' }

      should redirect_to intern_question_path question
      should set_the_flash.to(/erfolgreich/i)
    end

    it 'should re-render the edit form if update failed' do
      put :update, :id => question.id, :question => { :title => '', :body => '' }

      should render_template :edit
    end
  end
end
