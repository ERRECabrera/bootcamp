require "pry"
require "colorize"

class ShoppingCart
	
	def initialize(management=Management.new("$"))
		@cart = []
		@management = management
		@quantity = {}
		@sum_prices = nil
		@count_fruits = 1
	end

	def add_item(product_type)
		product = @management.iam?(product_type)
		if @cart.size == 0
			@cart << product
		else
			product_type_data = @cart.find {|cart| cart.type_data == product_type}
				if product_type_data
					product_type_data.quantity_ud += 1
				else
					@cart << product
				end
		end
	end

	def count_items
		@cart.each do |product|
			@quantity[product.type_data] = 1 + (@quantity[product.type_data] || 0)
		end
	end

	def show
		self.cost
		@cart.each_with_index {|product,index| puts "#{index+1}.".colorize(:blue)+" #{product.name}: ".colorize(:red)+"#{product.price}#{@management.divise}".colorize(:blue)+" x "+"#{product.quantity_ud}uds. = "+"#{@sum_prices[product.type_data]}#{@management.divise}".colorize(:green)}
	end

	def cost
		self.count_items
		@sum_prices = @management.cost_item(@cart,@quantity)
		cost = @management.cost_items(@cart,@quantity)
		return cost
	end

end

class Fruit
	attr_reader(:name, :type_data, :price, :type_discount, :parameter_discount)
	attr_accessor(:quantity_ud)

	def initialize(name,type_data,price,quantity_ud=nil,type_discount=nil,parameter_discount=nil,management=Management.new("$"))
		@name = name
		@type_data = type_data
		@price = price
		@management = management
		@type_discount = type_discount
		@parameter_discount = parameter_discount
		@quantity_ud = 1
	end

end

class Management
	attr_reader(:divise)

	def initialize(divise)
		@divise = divise
	end

	def cost_item(cart,quantity)
		sum_prices = {}
		quantity.each {|type_data,quantity_item| sum_prices[type_data] = apply_discount(0,quantity_item,type_data)}
		return sum_prices
	end

	def cost_items(cart,quantity)
		count = 0
		count_with_discount = quantity.each {|type_data,quantity_item| apply_discount(count,quantity_item,type_data)}
	end

	def apply_discount(count,quantity_item,type_data)
		product = iam?(type_data)
		if product.type_discount == nil
			count += product.price
		elsif product.type_discount == "2x1"
			if quantity_item%product.parameter_discount == 0
				discount = quantity_item/product.parameter_discount * product.price
				count -= discount
			else
				count += product.price	
			end
		elsif product.type_discount == "2+1"
			if quantity_item%product.parameter_discount == 0
				gift = iam?(gift)
				shoppingcart.add_product_to_cart(gift)
			else
				count += product.price
			end
		end
		return count
	end

	def iam?(type_data)
		if type_data == :apples
			Fruit.new("Manzana",type_data,10,"2x1",2)
		elsif type_data == :oranges
			Fruit.new("Naranja",type_data,5,"2x1",3)
		elsif type_data == :grapes
			Fruit.new("Uvas",type_data,15,"2+1",4)
		elsif type_data == :banana
			Fruit.new("Plátano",type_data,20)
		elsif type_data == :watermelon
			Fruit.new("Melón",type_data,50)
		elsif type_data == :gift
			Fruit.new("Plátano",type_data,0)
		else
			price = nil
		end
	end

end

class Shop

	def initialize(management=Management.new("$"))
		@management = management
	end

	def user_id(buyer)
		@user = buyer
		@cart_user = ShoppingCart.new(@management) 
	end

	def add_product_to_cart(product_type)
		@cart_user.add_item(product_type)
	end

	def print_bill
		puts @cart_user.show
		puts "Total: "+"#{@cart_user.cost}#{@management.divise}".colorize(:green)
		puts "--Thank you for your visit Mr. #{@user}--".colorize(:yellow)
	end

end

my_favorite_shop = Shop.new
my_favorite_shop.user_id("Raoul")

range_buy = 6..15
fruits = []
type_fruits = [:apples, :oranges, :grapes, :banana, :watermelon]
for i in 0..rand(range_buy)
	fruits << type_fruits[rand(type_fruits.size)]
end 

fruits.each {|fruit_type| my_favorite_shop.add_product_to_cart(fruit_type)}

my_favorite_shop.print_bill
binding.pry