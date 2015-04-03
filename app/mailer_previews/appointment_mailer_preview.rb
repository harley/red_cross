class AppointmentMailerPreview
  def reminder
    @appointment_id ||= Appointment.last.id
    AppointmentMailer.reminder @appointment_id
  end
end
