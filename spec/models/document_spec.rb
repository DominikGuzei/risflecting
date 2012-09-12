require 'spec_helper'

describe Document do
  it { should belong_to :uploader }

  it { should validate_presence_of :title }
  it { should validate_presence_of :asset }

  it 'should call the save_size method before a save' do
    document = FactoryGirl.build :document

    document.should_receive(:save_size).once

    document.save
  end

  describe '#save_size' do

    it 'should save the file size' do
      document = FactoryGirl.create :document

      document.size.should == document.asset.file.size
    end
  end
end
