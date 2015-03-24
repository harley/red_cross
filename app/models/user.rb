class User < ActiveRecord::Base
  attr_accessor :lookup_by_email

  validates :email, :netid, uniqueness: {allow_nil: true}
  has_many :appointments, dependent: :nullify
  before_save :fetch_if_yale_email

  def admin?
    role == 'admin'
  end

  def staff?
    role == 'staff'
  end

  def fetch_from_ldap
    raise "need email address" if email.blank?
    if user = YaleLDAP.lookup(email: email)
      self.fname = user[:first_name]
      self.lname = user[:last_name]
      self.class_year = user[:class_year]
      self.college = user[:college]
    end
  rescue Exception => e
  ensure
    self
  end

  def lookup_by_email?
    @lookup_by_email == '1'
  end

  private
  def fetch_if_yale_email
    if lookup_by_email? && yale_email?
      fetch_from_ldap
    end
  end

  def yale_email?
    email.present? && email.match(/@(.*)yale\.edu(.*)/)
  end
end
