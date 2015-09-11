class User < ActiveRecord::Base
  attr_accessor :lookup_by_email

  ROLES = ['admin', 'staff', '']

  validates :netid, uniqueness: {allow_blank: true}
  validates :email, uniqueness: {allow_blank: true}
  validates :email, presence: true, if: Proc.new {|user| user.netid.blank?}
  validates :role, inclusion: {in: ROLES}
  validate :require_netid_or_email

  has_many :appointments, dependent: :destroy
  has_many :drives, through: :appointments
  before_save :fetch_if_yale_email
  before_validation :normalize_role

  def admin?
    role == 'admin'
  end

  def staff?
    role == 'staff'
  end

  def member?
    role.blank? || role == 'donor'
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

  def email_or_netid
    email.presence || netid
  end

  def display
    "#{full_name} <#{email_or_netid}>"
  end

  def full_name
    "#{fname} #{lname}"
  end

  private
  def fetch_if_yale_email
    if lookup_by_email? && yale_email?
      fetch_from_ldap
    end
    self.lookup_by_email = nil
  end

  def yale_email?
    email.present? && email.match(/@(.*)yale\.edu(.*)/)
  end

  def normalize_role
    self.role ||= ''
  end

  def require_netid_or_email
    if netid.blank? && email.blank?
      self.errors.add :base, "requires either Netid or Email"
    end
  end
end
