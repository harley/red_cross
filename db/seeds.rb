# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Comfy::Cms::Site.find_or_create_by!(identifier: 'redcross') do |site|
  site.label = 'redcross'
  site.hostname = ENV['SITE_URL'] || 'red_cross.dev'
  site.locale = "en"
end
