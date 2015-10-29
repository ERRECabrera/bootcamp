require "pry"

module CameraPhoto

	def take_photo
		photo = "Photo taken in #{@operative_system}"
	end

end

class Device

	def initialize(operative_system,inches)
		@operative_system = operative_system
		@inches = inches
	end

	def show_time
		sleep 1
		puts Time.now
	end

end

class Agenda
	attr_reader(:agenda, :contact_name, :contact_selected, :contact_tf)

	def initialize
		@agenda = []	
		@contact_selected = nil
		@contact_tf = nil
		@contact_name = ""
	end

	def add_contact(name,tf)
		@agenda << {:name => name, :number => tf}
	end

	def read_contact(name)
		@contact_selected = @agenda.find {|contact| contact[:name] == name}
		@contact_tf = @contact_selected[:number]
		return @contact_tf
	end

	def read_telephone(number)
		@contact_selected =	@agenda.find {|contact| contact[:number] == number}
		if @contact_selected != nil
			@contact_name = @contact_selected[:name]	
		end
	end

end


class Phone < Device
	include CameraPhoto

	attr_reader(:contact_tf)

	def initialize(operative_system,inches,agenda)
		super(operative_system,inches)
		@agenda = agenda
		@contact_tf = nil
	end

	def add_contact(name,tf)
		@agenda.add_contact(name,tf)
	end
	
	def read_contact(name)
		@contact_tf = @agenda.read_contact(name)
	end

	def call_contact(number=@contact_tf)
		checker = @agenda.read_telephone(number)
		if checker != nil
			puts "Hello, I'm #{@agenda.contact_name}! Who are you?"
		else
			puts "Comunicando!"
		end
	end

end

class SmartSwatch < Device
	include CameraPhoto

	def show_time
		sleep 1
		puts "***#{Time.now}****"
	end

end

class Laptop < Device

	def initialize(operative_system,inches,touchable_boolean)
		super(operative_system,inches)
		@touchable = touchable_boolean
	end

end

class Microwave

	def initialize
	end

	def heat_food
		puts "Comida calentada!"
	end

	def show_time
		sleep 1
		puts Time.now
	end

end

my_agenda = Agenda.new
my_agenda.add_contact("Raúl",650278311)
my_agenda.add_contact("Estela",610922126)
my_agenda.add_contact("Ricard",666270300)
my_agenda.add_contact("House",916502783)

my_devices = [
	my_phone = Phone.new("Android",5.10, my_agenda),
	my_smartswatch = SmartSwatch.new("IOS",2),
	my_laptop = Laptop.new("Linux",15,false),
	my_microwave = Microwave.new
]

my_devices.each {|device| device.show_time}

my_microwave.heat_food

binding.pry