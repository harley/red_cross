class Appointment < ActiveRecord::Base
  belongs_to :user
  belongs_to :day
  belongs_to :drive

  serialize :slot_time, Tod::TimeOfDay

  def match_slot?(some_day, some_slot)
    day == some_day && slot_time == some_slot
  end

  def day_slot
    "#{day_id}@#{slot_time.strftime('%H:%M:%S')}"
  end

  def day_slot=(value)
    self.day_id, self.slot_time = *value.split('@')
  end
end
