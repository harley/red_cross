class Announcement < ActiveRecord::Base
  def self.primary
    where(primary: true).last
  end
end
