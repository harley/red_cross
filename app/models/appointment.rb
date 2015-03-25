class Appointment < ActiveRecord::Base
  belongs_to :user
  belongs_to :day
  belongs_to :drive

  serialize :slot_time, Tod::TimeOfDay

  accepts_nested_attributes_for :user

  def match_slot?(some_day, some_slot)
    day == some_day && slot_time == some_slot
  end

  def day_slot
    "#{day_id}@#{slot_time.strftime('%H:%M:%S')}"
  end

  def day_slot=(value)
    self.day_id, self.slot_time = *value.split('@')
  end

  def find_or_create_user!
    unless user.persisted?
      if user.netid.present? && record = User.where(netid: user.netid).first
        self.user_id = record.id
      elsif user.email.present? && record = User.where(email: user.email).first
        self.user_id = record.id
      end
    end
  end
end
