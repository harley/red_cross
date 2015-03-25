class DrivesController < ApplicationController
  before_action :require_user

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
    # TODO
    redirect_to new_drive_appointment_path(@drive)
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
end
