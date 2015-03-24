class Appointment < ActiveRecord::Base
  belongs_to :user
  belongs_to :day
  belongs_to :drive

  def match_slot?(slot)
    slot.to_s(:slot) == slot_time.to_s(:slot)
  end
end
