class AppointmentMailerPreview
  def reminder
    user_id = User.first.id
    drive_id = Drive.last.id
    AppointmentMailer.reminder user_id, drive_id
  end
end
