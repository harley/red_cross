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
end
