require 'spec_helper'

describe Role do
  before :each do
    Role.create :name => 'Test'
  end

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should have_many :users }
end
