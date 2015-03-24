require 'test_helper'

class DayTest < ActiveSupport::TestCase
  test "#available_slots" do
    day = days(:one)
    assert_equal TimeOfDay('09:00:00'), day.start_time
    assert_equal TimeOfDay('10:00:00'), day.stop_time
    s1 = TimeOfDay.new(9)
    s2 = TimeOfDay.new(9, 15)
    s3 = TimeOfDay.new(9, 30)
    s4 = TimeOfDay.new(9, 45)
    assert_equal [s1, s2, s3, s4], day.available_slots
  end

  test "#slot_capacity when empty" do
    day = days(:one)
    empty = {"09:00:00"=>0, "09:15:00"=>0, "09:30:00"=>0, "09:45:00"=>0}
    assert_equal empty, day.slot_capacity
  end

  test "#slot_capacity when there is 1 appointment" do
    day = days(:one)
    day.appointments.create!(slot_time: '09:00:00')
    day.appointments.create!(slot_time: '09:00:00')
    day.appointments.create!(slot_time: '09:30:00')
    result = {"09:00:00"=>2, "09:15:00"=>0, "09:30:00"=>1, "09:45:00"=>0}
    assert_equal result, day.slot_capacity
    assert_equal 2, day.drive.max_per_slot
    assert_equal true, day.slot_full?(TimeOfDay.new(9,0))
    assert_equal false, day.slot_full?(TimeOfDay.new(9,15))
  end
end
