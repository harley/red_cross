class AppointmentsController < ApplicationController
  def new
    @drive = Drive.find params[:drive_id]
    @appointment = Appointment.where(user: current_user, drive: @drive).first_or_create!
    redirect_to action: 'edit', id: @appointment.id
  end

  def edit
    @drive = Drive.find params[:drive_id]
    @appointment = Appointment.where(user: current_user, drive: @drive).first_or_create!
  end

  def update
    @drive = Drive.find params[:drive_id]
    if params[:appointment]
      @appointment = Appointment.where(user: current_user, drive: @drive).first_or_create!
      @appointment.update_attributes appointment_params
      @appointment.save!
      redirect_to action: 'edit', id: @appointment.id
    else
      redirect_to action: 'new'
    end
  end

  private
  def appointment_params
    params.require(:appointment).permit(:double_red, :slot_time, :day_id, :day_slot)
  end
end
