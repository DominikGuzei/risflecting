# encoding: utf-8
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

      should redirect_to intern_root_url
      should set_the_flash
    end
  end

  describe '#create' do
    it 'should give admins access' do
      sign_in FactoryGirl.create(:admin)
      post :create, :appointment => { :title => 'Title', :location => 'Here', :starttime => Time.now, :endtime => Time.now }

      should redirect_to intern_appointment_path Appointment.last
    end

    it 'should deny normal users access' do
      sign_in FactoryGirl.create(:user)
      post :create

      should redirect_to intern_root_url
      should set_the_flash
    end
  end

  describe '#accept' do
    before :each do
      @user = FactoryGirl.create(:user)
      sign_in @user
      @appointment = FactoryGirl.create :appointment
    end

    it 'should create an appointment acceptance for the current user' do
      post :accept, :id => @appointment

      @user.accepted_appointments.should include @appointment
    end

    it 'should redirect to the appointment´s detail page if successful' do
      post :accept, :id => @appointment

      should redirect_to intern_appointment_path @appointment
    end

    describe 'when passing remote=true' do
      it 'should return status 200 and render an HTML response if creation of an appointment rejection succeeded' do
        post :accept, :id => @appointment, :remote => true

        should render_template :acceptance_remote_response
        response.should be_success
      end
    end
  end

  describe '#reject' do
    before :each do
      @user = FactoryGirl.create(:user)
      sign_in @user
      @appointment = FactoryGirl.create :appointment
    end

    it 'should create an appointment rejection for the current user' do
      post :reject, :id => @appointment

      @user.rejected_appointments.should include @appointment
    end

    it 'should redirect to the appointment´s detail page if successful' do
      post :reject, :id => @appointment

      should redirect_to intern_appointment_path @appointment
    end

    describe 'when passing remote=true' do
      it 'should return status 200 and render an HTML response if creation of an appointment rejection succeeded' do
        post :reject, :id => @appointment, :remote => true

        should render_template :rejection_remote_response
        response.should be_success
      end
    end
  end

  describe '#destroy' do
    describe 'when logged in as an admin' do
      before :each do
        sign_in FactoryGirl.create(:admin)
        @appointment = FactoryGirl.create :appointment
      end

      it 'should delete the appointment' do
        delete :destroy, :id => @appointment

        Appointment.all.should_not include @appointment
      end

      it 'should set the flash if deletion was successful' do
        delete :destroy, :id => @appointment

        should set_the_flash.to /erfolgreich/i
      end
    end

    describe 'when logged in as a user' do
      it 'should deny normal user access' do
        sign_in FactoryGirl.create :user
        appointment = FactoryGirl.create :appointment

        delete :destroy, :id => appointment

        should redirect_to intern_root_url
        should set_the_flash
      end
    end
  end
end
