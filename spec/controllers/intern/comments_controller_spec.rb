require 'spec_helper'

describe Intern::CommentsController do
  describe '#create' do
    before :each do
      @user = FactoryGirl.create :user
      sign_in @user
    end
    after(:each) { @user.destroy }
    let(:question) { FactoryGirl.create :question }

    it 'should create a comment to a given question with the current user as author' do
      comment_text = 'Some special text'

      post :create, :comment => { :text => comment_text }, :question_id => question.id

      last_comment = Comment.last
      last_comment.question.should == question
      last_comment.author.should == @user
      last_comment.text.should == comment_text
    end

    it 'should redirect to the details page of the current question and give feedback about the success' do
      post :create, :comment => { :text => 'Some text' }, :question_id => question.id

      should redirect_to intern_question_path question
      should set_the_flash.to /erfolgreich/i
    end

    it 'should render the question details page if comment could not be created' do
      post :create, :comment => {}, :question_id => question.id # pass empty comment params to force an error

      should render_template 'intern/questions/show'
    end
  end
end
