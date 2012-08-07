require 'spec_helper'

describe User do
  it { should validate_presence_of :forename }
  it { should validate_presence_of :surname }
  it { should validate_presence_of :phone }

  describe 'passwords_match?' do
    it 'should return true if both passwords match' do
      user = User.new :password => 'test', :password_confirmation => 'test'

      user.passwords_match?.should be true
    end

    it 'should return false if the passwords do not match' do
      user = User.new :password => 'test', :password_confirmation => 'hello'

      user.passwords_match?.should be false
    end

    it 'should return false if both passwords are blank' do
      user = User.new :password => '', :password_confirmation => ''

      user.passwords_match?.should be false
    end
  end
end
