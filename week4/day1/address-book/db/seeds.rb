# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
names = %w{raul laura sergio miguel luna paloma}
surnames = %w{cabrera medina vazquez erausquin murillo costas}
rang_letters = "A".."F"
letters = rang_letters.to_a

names.each do |name|
  rand_names = rand(0..names.size-1)
  rand_surnames = rand(0..surnames.size-1)
  letters_rand = rand(0..letters.size-1)
  Contact.create(name: name, address: "C/#{names[rand_names]} #{surnames[rand_surnames]} #{rand(1..35)}, #{rand(1..7)}º#{letters[letters_rand]}" ,phoneNumber: "91#{rand(2..5)}#{rand(000000..999999)}", email: "#{name}@gmail.com")
end