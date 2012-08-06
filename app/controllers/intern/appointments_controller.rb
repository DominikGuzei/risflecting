# encoding: UTF-8
class Intern::AppointmentsController < InternController
  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new params[:appointment]
    if @appointment.save
      flash[:success] = "Ein neuer Termin wurde erstellt und veröffentlicht."
      redirect_to intern_appointment_path @appointment
    else
      render :action => :new
    end
  end

  def show
    @appointment = Appointment.find params[:id]
  end
end
