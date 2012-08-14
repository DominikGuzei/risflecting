require 'spec_helper'

describe AppointmentResponse do
  before :each do
    @appointment_response = FactoryGirl.create :appointment_response
  end

  after :each do
    @appointment_response.destroy
  end

  it { should ensure_inclusion_of(:accepted).in_array [true, false] }
  it { should validate_uniqueness_of(:appointment_id).scoped_to :user_id }

  it { should allow_mass_assignment_of :appointment_id }
  it { should allow_mass_assignment_of :user_id }
  it { should allow_mass_assignment_of :accepted }

  it { should belong_to :user }
  it { should belong_to :appointment }

  describe '#saved' do
    it 'should call the SmsHub method and pass an instance of itself' do
      SmsHub.should_receive(:appointment_response_saved).with(@appointment_response).once

      @appointment_response.save
    end
  end
end
