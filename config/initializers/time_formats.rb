formats = {
  am_pm: "%I:%M %p",
  slot: "%I:%M:%S",
  am_pm_long: "%b %e %Y, %l:%M %p"
}
Time::DATE_FORMATS.merge! formats
