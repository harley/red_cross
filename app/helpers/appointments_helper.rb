module AppointmentsHelper
  def am_pm(slot)
    slot.strftime(Time::DATE_FORMATS[:am_pm])
  end

  def slot_row_id(day, slot)
    "slot-row-#{day.id}-#{slot.strftime('%H%M%S')}"
  end
end
