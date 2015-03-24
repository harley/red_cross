class AppointmentsController < ApplicationController
  before_action :load_drive

  def new
    @appointment = Appointment.where(user: current_user, drive: @drive).first_or_create!
    redirect_to action: 'edit', id: @appointment.id
  end

  def edit
    @appointment = Appointment.where(user: current_user, drive: @drive).first_or_create!
  end

  def update
    if params[:appointment]
      @appointment = Appointment.where(user: current_user, drive: @drive).first_or_create!
      @appointment.update_attributes appointment_params
    end

    respond_to do |format|
      format.html do
        if @appointment
          redirect_to action: 'edit', id: @appointment.id
        else
          redirect_to action: 'new'
        end
      end
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
