require 'test_helper'

class DayTest < ActiveSupport::TestCase
  test "#available_slots" do
    day = days(:one)
    s1 = TimeOfDay.new(9).on(day.date)
    s2 = TimeOfDay.new(9, 15).on(day.date)
    s3 = TimeOfDay.new(9, 30).on(day.date)
    s4 = TimeOfDay.new(9, 45).on(day.date)
    assert_equal [s1, s2, s3, s4], day.available_slots
  end
end
