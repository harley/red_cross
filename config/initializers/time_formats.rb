formats = {
  am_pm: "%I:%M %p",
  slot: "%I:%M:%S",
  am_pm_long: "%b %e %Y, %l:%M %p",
  am_pm_long_tz: "%b %e %Y, %l:%M %p %Z",
  day_long: "%A, %B %d, %Y"
}
Time::DATE_FORMATS.merge! formats
Date::DATE_FORMATS.merge! formats
