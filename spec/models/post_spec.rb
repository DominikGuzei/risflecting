require 'spec_helper'

describe Post do
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  it { should belong_to :author }
  it { should have_many :comments }
end
