class AppointmentsController < ApplicationController
  before_action :require_user
  before_action :load_drive, except: [:index]

  def index
    @appointments = current_user.appointments
  end

  def new
    scope = Appointment.where(user: current_user, drive: @drive)
    @appointment = scope.first || scope.build
    @appointment.save(validate: false) unless @appointment.persisted?
    redirect_to edit_drive_appointment_path(@drive, @appointment)
  end

  def edit
    @appointment = @drive.appointments.find params[:id]
  end

  def update
    @appointment = Appointment.find params[:id]
    if params[:appointment]
      @appointment.update_attributes appointment_params
    end

    respond_to do |format|
      format.html do
        redirect_to action: 'edit', id: @appointment.id
      end
      format.js
    end
  end

  def destroy
    @appointment = @drive.appointments.find params[:id]
    @appointment.destroy
    redirect_to @drive
  end

  def remind
    @appointment = @drive.appointments.find params[:id]
    @appointment.remind!

    respond_to do |format|
      format.html { redirect_to admin_drive_appointments_path(@appointment.drive) }
      format.js
    end
  end

  private
  def appointment_params
    params.require(:appointment).permit(
      :double_red, :slot_time, :day_id, :day_slot,
      user_attributes: [:id, :netid, :email, :fname, :lname, :class_year, :college, :lookup_by_email]
    )
  end
  def load_drive
    @drive = Drive.find params[:drive_id]
  end
end
