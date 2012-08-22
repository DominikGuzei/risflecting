require 'spec_helper'

describe Comment do
  let(:question) { FactoryGirl.create :question }
  let(:user) { FactoryGirl.create :user }

  it { should belong_to :author }
  it { should belong_to :question }

  it { should validate_presence_of :text }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :question_id }

  it 'should touch the associated question on creation' do
    question.update_attribute :updated_at, 1.day.ago
    original_updated_at = question.updated_at

    question.comments.create :text => 'Some text', :author => user

    original_updated_at.should_not == Question.last.updated_at # performs new query - question.updated_at is cached
  end
end
