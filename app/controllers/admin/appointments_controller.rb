class Admin::AppointmentsController < Admin::BaseController
  helper_method :sorting_column
  helper_method :sorting_direction

  def index
    @drive = Drive.find params[:drive_id]
    @appointments = @drive.appointments.includes(:user, :day).order(sorting)
  end

  private

  def sorting
    column = sorting_column
    "#{column} #{sorting_direction}"
  end

  def sorting_column
    params[:sort][/^\-?(.+)/, 1] if params[:sort].present?
  end

  def sorting_direction
    params[:sort] =~ /^\-/ ? :desc : :asc if params[:sort].present?
  end
end
