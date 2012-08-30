# encoding: utf-8
require 'spec_helper'
require 'cancan/matchers'

describe User do
  it { should validate_presence_of :forename }
  it { should validate_presence_of :surname }
  it { should validate_presence_of :phone }

  it { should belong_to :role }
  it { should have_many :documents }
  it { should have_many :questions }
  it { should have_many :projects }
  it { should have_many :comments }
  it { should have_many :appointment_responses }
  it { should have_many(:accepted_appointments).through :appointment_responses }
  it { should have_many(:rejected_appointments).through :appointment_responses }

  describe '#passwords_match?' do
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

  describe '#has_role?' do
    let(:user) { FactoryGirl.create :user }

    before :each do
      Role.create! :name => 'Test'
      Role.create! :name => 'TestTest'
    end

    it 'should return true if the user has a specific role' do
      user.role = Role.find_by_name('Test')

      user.has_role?(:test).should be true
    end

    it 'should return false if the user does not have the specific role' do
      user.has_role?(:test).should be false
    end

    it 'should also work with two worded roles' do
      user.role = Role.find_by_name('TestTest')

      user.has_role?(:test_test).should be true
    end
  end

  describe '#accept_appointment' do

    let(:user) { FactoryGirl.create :user }
    let(:appointment) { FactoryGirl.create :appointment }

    it 'should create an appointment acceptance using the passed id' do
      user.accept_appointment appointment.id

      user.accepted_appointments.should include appointment
    end

    it 'should update an appointment rejection and make it an acceptance' do
      user.reject_appointment appointment.id

      user.accept_appointment appointment.id

      user.rejected_appointments.should_not include appointment
      user.accepted_appointments.should include appointment
    end
  end

  describe '#reject_appointment' do

    let(:user) { FactoryGirl.create :user }
    let(:appointment) { FactoryGirl.create :appointment }

    it 'should create an appointment rejection using the passed id' do
      user.reject_appointment appointment.id

      user.rejected_appointments.should include appointment
    end

    it 'should update an appointment acceptance and make it a rejection' do
      user.accept_appointment appointment.id

      user.reject_appointment appointment.id

      user.accepted_appointments.should_not include appointment
      user.rejected_appointments.should include appointment
    end
  end

  describe '#phone_number_has_correct_format' do
    it 'validates that the phone number is correctly formatted' do
      user = User.new :phone => '123'
      user.valid?

      user.errors[:phone].length.should equal 1
    end
  end

  describe '#normalize_phone' do
    it 'normalizes the phone number consistently' do
      user = FactoryGirl.build :user
      user.phone = '+43 664 2222 233'
      user.save

      user.phone.should eq '+436642222233'
    end
  end

  describe '#full_name' do
    it 'should return the user´s full name' do
      user = FactoryGirl.create :user

      user.full_name.should == user.forename + ' ' + user.surname
    end
  end

  describe '#formal_name' do
    it 'should return the user´s full name' do
      user = FactoryGirl.create :user

      user.formal_name.should == user.surname + ' ' + user.forename
    end
  end

  describe Ability do
    subject { ability }

    let(:ability) { Ability.new user }

    context 'admin user' do
      let(:user) { FactoryGirl.create :admin }

      it { should be_able_to :manage, :all }

      it { should be_able_to :add_attachment, user.questions.new }
      it { should_not be_able_to :add_attachment, Question.new }

      it { should be_able_to :add_attachment, user.projects.new }
      it { should_not be_able_to :add_attachment, Project.new }
    end

    context 'normal user' do
      let(:user) { FactoryGirl.create :user }

      it { should_not be_able_to :create,  Appointment.new }
      it { should_not be_able_to :update,  Appointment.new }
      it { should_not be_able_to :destroy, Appointment.new }
      it { should_not be_able_to :create,  User.new }
      it { should_not be_able_to :create,  Document.new }
      it { should_not be_able_to :destroy, Document.new }

      it { should be_able_to :add_attachment, user.questions.new }
      it { should_not be_able_to :add_attachment, Question.new }

      it { should be_able_to :add_attachment, user.projects.new }
      it { should_not be_able_to :add_attachment, Project.new }
    end

    context 'coordinator user' do
      let(:user) { FactoryGirl.create :coordinator }

      it { should_not be_able_to :create,  Appointment.new }
      it { should_not be_able_to :update,  Appointment.new }
      it { should_not be_able_to :destroy, Appointment.new }
      it { should_not be_able_to :create,  User.new }

      it { should be_able_to :add_attachment, user.questions.new }
      it { should_not be_able_to :add_attachment, Question.new }

      it { should be_able_to :add_attachment, user.projects.new }
      it { should_not be_able_to :add_attachment, Project.new }
    end
  end
end
