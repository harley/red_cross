class AppointmentsController < ApplicationController
  def new
    @drive = Drive.find params[:drive_id]
    @appointment = Appointment.new
  end
end
