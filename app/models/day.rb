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

  def slot_capacity(lazy = true)
    return @slot_capacity if defined?(@slot_capacity) && lazy
    @slot_capacity = {}
    available_slots.each do |slot|
      @slot_capacity[slot.to_s] = Appointment.where(day_id: id, slot_time: slot.to_s).count
    end
    @slot_capacity
  end

  def slot_status(slot)
    "%s/%s" % [slot_capacity[slot.to_s], drive.max_per_slot]
  end

  def slot_full?(slot)
    slot_capacity[slot.to_s] >= drive.max_per_slot
  end

  def appointments_at(slot)
    appointments.where(slot_time: slot.to_s)
  end
end
