require 'spec_helper'
require 'cancan/matchers'

describe User do
  it { should validate_presence_of :forename }
  it { should validate_presence_of :surname }
  it { should validate_presence_of :phone }
  it { should have_and_belong_to_many :roles }

  it { should have_many :appointment_responses }
  it { should have_many(:accepted_appointments).through :appointment_responses }

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

  describe 'has_role?' do
    let(:user) { FactoryGirl.create :user }

    before :each do
      Role.create! :name => 'Admin'
      Role.create! :name => 'SuperAdmin'
    end

    it 'should return true if the user has a specific role' do
      user.roles << Role.find_by_name('Admin')

      user.has_role?(:admin).should be true
    end

    it 'should return false if the user does not have the specific role' do
      user.has_role?(:admin).should be false
    end

    it 'should also work with two worded roles' do
      user.roles << Role.find_by_name('SuperAdmin')

      user.has_role?(:super_admin).should be true
    end
  end

  describe 'accept_appointment' do

    let(:user) { FactoryGirl.create :user }
    let(:appointment) { FactoryGirl.create :appointment }

    it 'should create an appointment acceptance using the passed id' do
      user.accept_appointment appointment.id

      user.accepted_appointments.should include(appointment)
    end
  end

  describe 'abilities' do
    subject { ability }

    let(:ability) { Ability.new user }

    context 'admin user' do
      let(:user) { FactoryGirl.create :admin }

      it { should be_able_to(:manage, :all) }
    end

    context 'normal user' do
      let(:user) { FactoryGirl.create :user }

      it { should_not be_able_to(:create, Appointment.new) }
      it { should_not be_able_to(:update, Appointment.new) }
      it { should_not be_able_to(:destroy, Appointment.new) }
      it { should_not be_able_to(:create, User.new) }
    end
  end
end
