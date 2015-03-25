class Drive < ActiveRecord::Base
  has_many :days
  has_many :appointments, through: :days
  accepts_nested_attributes_for :days, allow_destroy: true, reject_if: proc {|attrs| attrs['start_time'].blank? && attrs['stop_time'].blank?}

  rails_admin do
    edit do
      field :name
      field :location
      field :contact_email
      field :max_per_slot
      field :time_per_slot
    end
  end
end
