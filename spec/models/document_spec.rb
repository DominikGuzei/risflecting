require 'spec_helper'

describe Document do
  it { should belong_to :uploader }

  it { should validate_presence_of :title }
  it { should validate_presence_of :asset }
end
