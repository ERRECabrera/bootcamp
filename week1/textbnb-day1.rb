require "pry"

class Home
	attr_reader(:name, :city, :price, :capacity)

	def initialize(name,city,price,capacity)
		@name = name
		@city = city
		@price = price
		@capacity = capacity
	end
end

def homes
	name_array = %w{Raúl Rubén Gonzalo Laura David Lara Fernando Isaura Giancarlo Carlos}
	city_array = %w{Toledo Madrid Sevilla Barcelona Bilbao Cádiz Tenerife Valencia Málaga Salamanca}
	price_array = 10..50
	capacity_array = 1..7
	homes = name_array.map do |name|
		name_id = name_array[rand(name_array.length)]
		city_id = city_array[rand(city_array.length)]
		capacity_id = rand(capacity_array)
		price_id = rand(price_array)*capacity_id
		Home.new(name_id, city_id , price_id, capacity_id)
	end
	return homes
end

class Menu
	attr_accessor(:array_homes)

	def initialize(array_homes)
		@array_homes = array_homes
		@homes_cache = @array_homes
	end

	def begin
		list_homes(@homes_cache)
		option_input = ""
		while !/[1-3]/.match(option_input)
			puts "Pulse:\n[1] para ordenar los resultados\n[2] para filtrarlos\n[3] para salir"
			option_input = gets.chomp
			if option_input == "1"
				sort_activator = false
				while sort_activator != true
					puts "Puede ordenar los resultados por \"precio\" o por \"capacidad\".\n¿Cómo desea ordenarlos?"
					sort_input = gets.chomp.downcase
					if sort_input.include?("precio")
						condition_sort = ""
						while !/[1-2]/.match(condition_sort)
							puts "Pulse:\n[1] si desea ordenarlos de mayor a menor\n[2] si desea ordenarlos de menor a mayor"
							condition_sort = gets.chomp
							if condition_sort == "1"
								@homes_cache = price_sort("hight")
								sort_activator = true
							elsif condition_sort == "2"
								@homes_cache = price_sort("low")
								sort_activator = true
							end							
						end
					elsif sort_input.include?("capacidad")
						condition_sort = ""
						while !/[1-2]/.match(condition_sort)
							puts "Pulse:\n[1] si desea ordenarlos de mayor a menor\n[2] si desea ordenarlos de menor a mayor"
							condition_sort = gets.chomp
							if condition_sort == "1"
								@homes_cache = capacity_sort("hight")
								sort_activator = true
							elsif condition_sort == "2"
								@homes_cache = capacity_sort("low")
								sort_activator = true
							end
						end
					end
				end
			elsif option_input == "2"
				sort_activator = false
				while sort_activator != true
					puts "Puede filtrar los resultados por \"ciudad\" o por \"precio\".\n¿Qué filtro desea aplicar?"
					sort_input = gets.chomp.downcase
					if sort_input.include?("ciudad")
						city_activator = false
						while city_activator != true
							puts "Puede elegir entre nuestras actuales ciudades:"
							cities = @homes_cache.map {|home| home.city}
							cities_uniq = cities.uniq
							cities_uniq.each {|city| puts city}
							city_input = gets.chomp.downcase
							cities_uniq.each do |city|
								if city.downcase.include?(city_input)
									@homes_cache = filter_city(city_input)
									sort_activator = true
									city_activator = true
								end
							end
						end
					elsif sort_input.include?("precio")
						puts "Escriba el precio máximo que está dispuesto a pagar:"
						price_input = gets.chomp.to_i
						if filter_price(price_input) != nil
							@homes_cache = filter_price(price_input)
							sort_activator = true
						else
							minimal_price = @homes_cache.price.sorted[-1]
							puts "Nuestro oferta mínima actual es de #{minimal_price}€"
							@homes_cache = filter_price(minimal_price)
							sort_activator = true
						end
					end
				end
			elsif option_input == "3"
				return @homes_cache
			end
		end
		self.begin()
	end

	def price_sort(condition_sort)
		if condition_sort.capitalize =~ /^L/
			sorted = @homes_cache.sort do |home1,home2|
				home1.price <=> home2.price
			end
		elsif condition_sort.capitalize =~ /^H/
			sorted = @homes_cache.sort do |home1,home2|
				home2.price <=> home1.price
			end
		end
		return sorted
	end

	def capacity_sort(condition_sort)
		if condition_sort.capitalize =~ /^L/
			sorted = @homes_cache.sort do |home1,home2|
				home1.capacity <=> home2.capacity
			end
		elsif condition_sort.capitalize =~ /^H/
			sorted = @homes_cache.sort do |home1,home2|
				home2.capacity <=> home1.capacity
			end
		end
		return sorted
	end

	def filter_city(city_input)
		filtered = @homes_cache.select {|home| home.city.downcase == city_input}
		return filtered
	end

	def filter_price(price_input)
		filtered = @homes_cache.select {|home| home.price <= price_input}
		return filtered
	end

	def list_homes(array_homes)
		puts "Estas son nuestras casas disponibles:"
		@homes_cache.each_with_index {|home,index| puts "#{index+1} - La casa de #{home.name} está en #{home.city}\nEl precio es de #{home.price}. Y la capacidad es de #{home.capacity} personas."}
	end
end


homes_array = homes()
menu_example = Menu.new(homes_array)
menu_example.begin