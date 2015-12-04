# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
names = %w{raul juan lucas sergio oscar jose miguel}
surnames = %w{cabrera medina angulo perez santos}
factions =  %w{ terrans zergs protoss}
num_players = 15
num_matches = 7

num_players.times do
 Player.create({name: "#{names[rand(0..names.size-1)]} #{surnames[rand(0..surnames.size-1)]}"})
end

def return_array_with_two_rands_index_not_repeat(size_array_elements)
  arr = []
  first_rand = rand(0..size_array_elements)
  arr.push(first_rand)
  second_rand = rand(0..size_array_elements)
  while first_rand == second_rand
    second_rand = rand(0..size_array_elements)
  end
  arr.push(second_rand)
  return arr
end

num_matches.times do
  rand_factions = return_array_with_two_rands_index_not_repeat(factions.size-1)
  rand_players = return_array_with_two_rands_index_not_repeat(num_players)
  Match.create({
    winner_faction: factions[rand_factions[0]],
    loser_faction: factions[rand_factions[1]],
    duration: Time.now,
    date: Date.today,
    winner_id: rand_players[0],
    loser_id: rand_players[1]
  })
end