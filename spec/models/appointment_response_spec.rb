require 'spec_helper'

describe AppointmentResponse do
  before :all do
    @appointment_response = AppointmentResponse.create :appointment_id => 1, :user_id => 1, :accepted => true
  end

  after :all do
    @appointment_response.destroy
  end

  it { should ensure_inclusion_of(:accepted).in_array [true, false] }
  it { should validate_uniqueness_of(:appointment_id).scoped_to :user_id }

  it { should allow_mass_assignment_of :appointment_id }
  it { should allow_mass_assignment_of :user_id }
  it { should allow_mass_assignment_of :accepted }

  it { should belong_to :user }
  it { should belong_to :appointment }
end
