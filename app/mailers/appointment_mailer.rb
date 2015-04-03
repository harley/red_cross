class AppointmentMailer < ApplicationMailer
  def reminder(appointment_id)
    @appointment = Appointment.find appointment_id
    @user = @appointment.user
    @drive = @appointment.drive

    # you can provide values to be interpolated with %{}, e.g. "Hello %{user}"
    mail subject: cms_email_subject(drive_title: @drive.name),
         to: @user.email,
         from: @drive.contact_email
  end

  helper do
    def full_name
      @user.full_name
    end

    def slot_time
      @appointment.exact_time.to_s(:am_pm_long_tz)
    end

    def drive_location
      @drive.location
    end

    def appointment_url
      drive_appointment_url(@drive, @appointment)
    end

    def drive_contact_email
      @drive.contact_email
    end
  end
end
