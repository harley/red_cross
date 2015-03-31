class Day < ActiveRecord::Base
  belongs_to :drive
  has_many :appointments, dependent: :destroy

  serialize :start_time, Tod::TimeOfDay
  serialize :stop_time, Tod::TimeOfDay

  rails_admin do
    list do
      field :id
      field :drive
      field :date
      field :start_time, :string do
        pretty_value { TimeOfDay(value.to_s).strftime(Time::DATE_FORMATS[:am_pm]) }
      end
      field :stop_time, :string do
        pretty_value { TimeOfDay(value.to_s).strftime(Time::DATE_FORMATS[:am_pm]) }
      end
      field :created_at
      field :updated_at
      # appointments
    end
  end

  def available_slots
    return @available_slots if defined?(@available_slots)
    @available_slots = []
    if start_time && stop_time
      current_time = start_time
      while current_time < stop_time do
        @available_slots.push current_time
        current_time += drive.time_per_slot.minutes
      end
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

  def confirmed_appointment_count
    @confirmed_appointment_count ||= appointments.where.not(slot_time: nil).count
  end
end
