class Appointment < ActiveRecord::Base
  belongs_to :user
  belongs_to :day
  belongs_to :drive

  serialize :slot_time, Tod::TimeOfDay

  accepts_nested_attributes_for :user
  validates :slot_time, presence: true

  delegate :date, to: :day

  def exact_time
    if slot_time and day
      slot_time.on day.date
    end
  end

  def confirmed?
    !!slot_time
  end

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

  def user_attributes=(user_attrs)
    self.user = User.find_or_initialize_by(id: user_attrs.delete(:id))
    self.user.attributes = user_attrs
  end
end
