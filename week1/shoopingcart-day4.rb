require "pry"
require "colorize"

class ShoppingCart
	
	def initialize(management=Management.new("$"))
		@cart = []
		@management = management
	end

	def add_item(product)
		@cart << product
	end

	def show #cambió de donde viene el precio
		@cart.each_with_index {|product, index| puts "#{index+1}".colorize(:blue)+" #{product.name}:".colorize(:red)+"#{product.price}#{@management.divise}".colorize(:blue)}
	end

	def cost
		@management.cost_items(@cart)
	end

end

class Fruit
	attr_reader(:name, :type)

	def initialize(name,type,management=Management.new("$"))
		@name = name
		@type = type
		@management = management
	end

	def price
		@management.calc_price(@type)
	end

end

class Management
	attr_reader(:divise)

	def initialize(divise)
		@divise = divise
	end

	def cost_items(array_objects)
		price = 0
		array_objects.each do |product|
			price = product.price
		end
		return price
	end

	def calc_price(type)
		if type == :apples
			price = 10
		elsif type == :oranges
			price = 5
		elsif type == :grapes
			price = 15
		elsif type == :banana
			price = 20
		elsif type == :watermelon
			price = 50
		else
			price = nil
		end
	end

end

class Shop

	def initialize(management=Management.new("$"))
		@management = management
	end

	def user_id(user)
		@user = user
		@cart_user = ShoppingCart.new(@management) 
	end

	def add_product_to_cart(product)
		@cart_user.add_item(product)
	end

	def print_bill
		puts @cart_user.show
		puts "Total: "+"#{@cart_user.cost}#{@management.divise}".colorize(:green)
		puts "--Thank you for your visit Mr. #{@user}--".colorize(:orange)
	end

end

fruits =[
manzana = Fruit.new("Manzana",:apples),
naranja = Fruit.new("Naranja",:oranges),
uvas = Fruit.new("Uvas",:grapes),
platano = Fruit.new("Plátano",:banana),
meĺon = Fruit.new("Melón",:watermelon)
]

my_favorite_shop = Shop.new

my_favorite_shop.user_id("Raoul")

fruits.each {|fruit| my_favorite_shop.add_product_to_cart(fruit)}

binding.pry
my_favorite_shop.print_bill
