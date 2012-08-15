require 'spec_helper'

describe Intern::CommentsController do
  describe '#create' do
    before(:each)      { sign_in FactoryGirl.create :user }
    let(:post_instance) { FactoryGirl.create :post } # uses post_instance because of naming conflicts with 'post' method

    it 'should create a comment to a given post' do
      comment_text = 'Some special text'

      post :create, :comment => { :text => comment_text }, :post_id => post_instance.id

      last_comment = Comment.last
      last_comment.post.should == post_instance
      last_comment.text.should == comment_text
    end

    it 'should redirect to the details page of the current post and give feedback about the success' do
      post :create, :comment => { :text => 'Some text' }, :post_id => post_instance.id

      should redirect_to intern_post_path post_instance
      should set_the_flash.to /erfolgreich/i
    end

    it 'should render the post details page if comment could not be created' do
      post :create, :comment => {}, :post_id => post_instance.id

      should render_template 'intern/posts/show'
    end
  end
end
