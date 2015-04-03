class AppointmentMailer < ApplicationMailer
  def reminder(user_id, drive_id)
    @user = User.find user_id
    @drive = Drive.find drive_id

    # you can provide values to be interpolated with %{}, e.g. "Hello %{user}"
    mail subject: cms_email_subject(first_name: @user.fname),
         to: @user.email,
         from: @drive.contact_email
  end
end
