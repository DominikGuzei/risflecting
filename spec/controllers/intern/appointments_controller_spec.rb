require 'spec_helper'

describe Intern::AppointmentsController do
  describe '#new' do
    it 'should give admins access' do
      sign_in FactoryGirl.create(:admin)
      get :new

      response.should be_success
    end

    it 'should deny normal users access' do
      sign_in FactoryGirl.create(:user)
      get :new

      response.should redirect_to intern_root_url
      flash[:error].should_not be_nil
    end
  end

  describe '#create' do
    it 'should give admins access' do
      sign_in FactoryGirl.create(:admin)
      post :create, :appointment => { :title => 'Title', :location => 'Here', :starttime => Time.now, :endtime => Time.now }

      response.should redirect_to intern_appointment_path Appointment.last
    end

    it 'should deny normal users access' do
      sign_in FactoryGirl.create(:user)
      post :create

      response.should redirect_to intern_root_url
      flash[:error].should_not be_nil
    end
  end

  describe '#accept' do
    before :each do
      sign_in FactoryGirl.create(:user)
      @appointment = FactoryGirl.create :appointment
    end

    it 'should create an appointment acceptance for the current user' do
      post :accept, :id => @appointment

      response.code.should render_template :accepted_appointment
    end

    it 'should return status 200 if the creation of the appointment acceptance was successful' do
      post :accept, :id => @appointment

      response.code.to_i.should == 200
    end
  end
end
