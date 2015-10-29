def game
	puts "Hola, ¿Cúal es tu nombre?"
	name = gets.chomp
	number = rand(1..5)
	puts "Bien #{name}, estoy pensando en un número. Lo adivinas???"
	prueba = gets.chomp.to_i
	contador = 0
	vidas = 6
	while prueba != number && vidas != 0
		if prueba > number
			puts "Error 407!! El número es menor"
			prueba = gets.chomp.to_i
		elsif prueba < number
			puts "Error 809!! El número es mayor"
			prueba = gets.chomp.to_i
		end
	contador += 1
	vidas -= 1		
	end
	if vidas == 0
			puts "Lo siento #{name} te has quedado sin vidas!!!"
	else 
		puts "Felicidades, haz encontrado el número!!!\nEra #{number}\nSólo han sido #{contador} intentos"
	end
end

game
