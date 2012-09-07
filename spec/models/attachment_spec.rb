require 'spec_helper'

describe Attachment do
  let(:question) { FactoryGirl.create :question }
  let(:project) { FactoryGirl.create :project }

  it { should belong_to :attachable }
  it { should validate_presence_of :file }

  it 'should touch the associated question on creation' do
    question.update_attribute :updated_at, 1.day.ago
    original_updated_at = question.updated_at

    FactoryGirl.create :attachment, :attachable => question
    original_updated_at.should_not == Question.last.updated_at # performs new query - question.updated_at is cached
  end

  it 'should touch the associated project on creation' do
    project.update_attribute :updated_at, 1.day.ago
    original_updated_at = project.updated_at

    FactoryGirl.create :attachment, :attachable => project
    original_updated_at.should_not == Project.last.updated_at # performs new query - project.updated_at is cached
  end

  it 'should call the save_size method before a save' do
    attachment = FactoryGirl.build :attachment

    attachment.should_receive(:save_size).once

    attachment.save
  end

  describe '#save_size' do
    it 'should save the file size' do
      attachment = FactoryGirl.create :attachment

      attachment.size.should == attachment.file.file.size
    end
  end
end
