require 'spec_helper'

describe Comment do
  let(:post_instance) { FactoryGirl.create :post }

  it { should belong_to :author }
  it { should belong_to :post }

  it { should validate_presence_of :text }

  it 'should touch the post on creation' do
    original_updated_at = post_instance.updated_at

    post_instance.comments.create :text => 'Some text'

    last_post = Post.last
    post_instance.should == last_post
    original_updated_at.should_not == last_post.updated_at
  end
end
