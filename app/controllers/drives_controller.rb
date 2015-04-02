class DrivesController < ApplicationController
  before_action :require_user

  def kiosk
    @drive = Drive.find params[:id]
    @appointment = @drive.appointments.build
    @appointment.build_user
    authorize @drive, :kiosk?
  end

  def add_appointment
    @drive = Drive.find params[:id]
    @appointment = @drive.appointments.build new_appointment_params
    @lookup_by_email = @appointment.user.lookup_by_email?
    @appointment.find_or_create_user!
    @appointment.user.save
    if @appointment.save
      flash[:success] = "Added an appointment for #{@appointment.user.display}"
      redirect_to action: 'kiosk'
    else
      unless @lookup_by_email
        flash.now[:error] = @appointment.errors.full_messages.to_sentence
      end
      render action: 'kiosk'
    end
  end

  def index
    # TODO: pagination
    if current_admin
      @drives = Drive.all
    elsif current_user
      @drives = current_user.drives
    end
  end

  def show
    @drive = Drive.find params[:id]
  end

  def edit
    @drive = Drive.find params[:id]
    @drive.days.build
  end

  def update
    @drive = Drive.find params[:id]
    if @drive.update_attributes drive_params
      flash[:success] = "Changes saved."
      redirect_to edit_drive_path(@drive)
    else
      render 'edit'
    end
  end

  private
  def drive_params
    params.require(:drive).permit!
  end

  def new_appointment_params
    params.require(:appointment).permit(
      :double_red, :slot_time, :day_id, :day_slot, :open_at,
      user_attributes: [:id, :netid, :email, :fname, :lname, :class_year, :college, :lookup_by_email]
    )
  end
end
