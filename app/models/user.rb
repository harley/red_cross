class User < ActiveRecord::Base
  require 'net/ldap'

  validates :email, :netid, uniqueness: true

  def fetch_from_ldap
    # Setup our LDAP connection
    ldap = Net::LDAP.new( host: "directory.yale.edu", port: 389 )
    # We filter results based on email
    filter = Net::LDAP::Filter.eq( "email", email)
    ldap.open do |ldap|
      # Search, limiting results to yale domain and people
      ldap.search(base: "ou=People,o=yale.edu", filter: filter, return_result: false) do |entry|
        self.fname = "#{entry['givenname']}"
        self.lname  = "#{entry['sn']}"
        self.email = "#{entry['mail']}"
        self.college = entry['college'].first
        self.class_year = entry['class'].first
        # self.phone = entry['studentphonenumber'].first
      end
    end
  rescue
     errors.add_to_base "LDAP Error: " + $! # Will trigger an error, LDAP is probably down
     false
  end
end
