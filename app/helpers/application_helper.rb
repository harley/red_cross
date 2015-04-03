module ApplicationHelper
  def flasherize key
    case key
    when 'notice'
      'alert-info'
    when 'error'
      'alert-danger'
    when 'alert'
      'alert-warning'
    else
      "alert-#{key}"
    end
  end

  def time_vs_now(a)
    if a > Time.now
      time_ago_in_words(a) + ' from now'
    else
      time_ago_in_words(a) + ' ago'
    end
  end

  def markdown(text)
    Kramdown::Document.new(text).to_html.html_safe
  end
end
