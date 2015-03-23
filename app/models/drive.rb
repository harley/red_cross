class Drive < ActiveRecord::Base
  has_many :days
  accepts_nested_attributes_for :days, allow_destroy: true, reject_if: proc {|attrs| attrs['start_time'].blank? && attrs['stop_time'].blank?}
end
