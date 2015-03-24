require 'test_helper'

class AppointmentTest < ActiveSupport::TestCase
  test "setting slot_time" do
    appointment = Appointment.new slot_time: '14:45:00'
    assert_equal TimeOfDay('14:45:00'), appointment.slot_time
  end

  test "#day_slot" do
    day = days(:one)
    appointment = Appointment.new day: day, slot_time: '11:11:00'
    assert_equal "#{day.id}@11:11:00", appointment.day_slot
  end

  test "#day_slot=" do
    day = days(:one)
    appointment = Appointment.new day_slot: "#{day.id}@11:11:00"
    assert_equal day, appointment.day
    assert_equal TimeOfDay.new(11, 11), appointment.slot_time

  end
end
