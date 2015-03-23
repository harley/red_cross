class User < ActiveRecord::Base
  validates :email, :netid, uniqueness: true

  def fetch_from_ldap
    raise "need email address" if email.blank?
    if user = YaleLDAP.lookup(email: "casey.watts@yale.edu")
      self.fname = user[:first_name]
      self.lname = user[:last_name]
      self.class_year = user[:class_year]
      self.college = user[:college]
    end
    self
  end
end
