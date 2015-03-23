class Drive < ActiveRecord::Base
  has_many :days
  accepts_nested_attributes_for :days
end
