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
end
