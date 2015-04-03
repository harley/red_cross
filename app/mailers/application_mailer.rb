class ApplicationMailer < ActionMailer::Base
  helper ::CmsEmailHelper
  default from: ENV['DEFAULT_FROM'] || "noreply@yale.edu"
  layout 'mailer'
end
