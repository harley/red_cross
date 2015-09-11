module CmsEmailHelper
  def cms_email_snippet(*args)
    Kramdown::Document.new(super).to_html.html_safe
  end
end
