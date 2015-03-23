class User < ActiveRecord::Base
  require 'net/ldap'

  validates :email, :netid, uniqueness: true

  def self.fetch_user_info
  end
end
