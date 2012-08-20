require 'spec_helper'

describe Post do
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  it { should belong_to :author }
  it { should have_many :comments }
  it { should have_many :attachments }

  describe '#recent_alternative_posts' do
    it 'should get a maximum of 5 alternative posts' do
      FactoryGirl.create_list :post, 10

      Post.first.recent_alternative_posts.length.should be 5
    end

    it 'should not include itself' do
      FactoryGirl.create_list :post, 5

      posts = Post.first.recent_alternative_posts

      posts.length.should be 4
      posts.include?(Post.first).should be false
    end

    it 'should include the most recent posts' do
      FactoryGirl.create_list :post, 10

      Post.first.recent_alternative_posts.should =~ Post.limit(5).order('updated_at DESC')
    end
  end
end
