# encoding: UTF-8
class Intern::AppointmentsController < InternController
  load_and_authorize_resource

  def index
    @appointments = Appointment.all
    @accepted_appointments = current_intern_user.accepted_appointments
    @rejected_appointments = current_intern_user.rejected_appointments
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
    @accepting_users = @appointment.accepting_users
    @rejecting_users = @appointment.rejecting_users
  end

  def accept
    if current_intern_user.accept_appointment params[:id]
      return redirect_to intern_appointment_path(params[:id]) unless params[:remote]
      render :partial => 'acceptance_remote_response', :locals => { :appointment => params[:id] }
    else
      return head :error
    end
  end

  def reject
    if current_intern_user.reject_appointment params[:id]
      return redirect_to intern_appointment_path(params[:id]) unless params[:remote]
      render :partial => 'rejection_remote_response', :locals => { :appointment => params[:id] }
    else
      return head :error
    end
  end

  def destroy
    appointment = Appointment.find params[:id]
    if appointment.destroy
      flash[:success] = "Der Termin '#{appointment.title}' wurde erfolgreich gelöscht."
    else
      flash[:error] = "Der Termin '#{appointment.title}' konnte nicht gelöscht werden. Bitte versuche es erneut, oder wende dich an das Entwicklerteam."
    end

    redirect_to intern_appointments_path
  end
end
