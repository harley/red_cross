class Drive < ActiveRecord::Base
  has_many :days, dependent: :destroy
  has_many :appointments, dependent: :destroy
  accepts_nested_attributes_for :days, allow_destroy: true, reject_if: proc {|attrs| attrs['start_time'].blank? && attrs['stop_time'].blank?}

  validates :name, presence: true

  scope :open, -> {where.not(open_at: nil)}

  rails_admin do
    edit do
      field :name
      field :location
      field :contact_email
      field :open_at
      field :max_per_slot
      field :time_per_slot
    end
  end
end
