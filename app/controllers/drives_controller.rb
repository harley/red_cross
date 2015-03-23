class DrivesController < ApplicationController
  def edit
    @drive = Drive.find params[:id]
    @drive.days.build if @drive.days.empty?
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
    params[:drive].permit!
  end
end
