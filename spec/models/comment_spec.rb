require 'spec_helper'

describe Comment do
  let(:post_instance) { FactoryGirl.create :post }
  let(:user) { FactoryGirl.create :user }

  it { should belong_to :author }
  it { should belong_to :post }

  it { should validate_presence_of :text }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :post_id }

  it 'should touch the post on creation' do
    post_instance.update_attribute :updated_at, 1.day.ago
    original_updated_at = post_instance.updated_at

    post_instance.comments.create :text => 'Some text', :author => user

    original_updated_at.should_not == Post.last.updated_at # performs new query - post_instance.updated_at is cached
  end
end
