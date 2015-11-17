# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

(1..25).each do |num|
	Project.create name: "Project #{num}", description: "a"*num
end

(1..50).each do |num|
  Entry.create(project_id: rand(1..25), hours: rand(0..3), minutes: rand(00..59), comments: "larala"*rand(0..num), date: Time.now-rand(1..num).hours)
end