class Day < ActiveRecord::Base
  belongs_to :drive
  has_many :appointments

  serialize :start_time, Tod::TimeOfDay
  serialize :stop_time, Tod::TimeOfDay

  def available_slots
    return @available_slots if defined?(@available_slots)
    @available_slots = []
    current_time = start_time
    while current_time < stop_time do
      @available_slots.push current_time
      current_time += drive.time_per_slot.minutes
    end
    @available_slots
  end
end
