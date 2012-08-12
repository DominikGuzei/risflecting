# encoding: UTF-8
class Intern::AppointmentsController < InternController
  load_and_authorize_resource

  def index
    @appointments = Appointment.all
    @accepted_appointments = current_intern_user.accepted_appointments
  end

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new params[:appointment]
    if @appointment.save
      flash[:success] = "Ein neuer Termin wurde erstellt und veröffentlicht."
      redirect_to intern_appointment_path @appointment
    else
      render :new
    end
  end

  def show
    @appointment = Appointment.find params[:id]
  end

  def accept
    if current_intern_user.accept_appointment params[:id]
      render :partial => 'accepted_appointment', :locals => { :status => 'zugesagt' }, :status => 200
    else
      head :error
    end
  end

  def reject
  end
end
