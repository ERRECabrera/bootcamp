# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
range_after_days = (0..7)
(1..30).each {|num| Concert.create(band: "band##{num}", venue: "C/Calle,#{num}", city: "City#{num}", date: Time.now-rand(range_after_days).days, price: rand(5..45) , description: "description##{num}")} 