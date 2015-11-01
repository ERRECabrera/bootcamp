require "pry"

module Movements
#=begin
	def pawn(piece,new_position)
		if self.colour == :white
			#calcula si el movimiento supera los límites de la pieza limites:[pasos],movs[[vertical0][horizontal1]diagonal01]
				#pasos es límite para index[vertical][horizontal] aplicable a peon(2,1), caballo(2,1||1,2) y rey(1,1)
				#mov only_vertical = index[horizontal1] == 0
				#mov only_horizontal = index[vertical0] == 0
				#mov diagonal = constante( (piece.position[0] - piece.position[1]).abs == (new_position[0] - new_position[1]).abs ) 
				#mov salto_caballo = operation_index[2.abs] && operation_index[1.abs] || operation_index[1.abs] && operation_index[2.abs]
			if piece.limit[0 vertical][-2..-1].include?(operation[0]) && operation[1] == -1 piece.limit[1 horizontal]
				#calcula el rango d movimientos posibles
				if operation[0] > 0
					range_position[0] = 
				end
			else
				return false
			end
		elsif self.colour == :black
			operation == limit [[+1..+2 limit[vertical]], +1 limit[horizontal]]
				if operation[0] < 0
		end
	end

	def knight(piece,new_position)
		se puede mover en esa dirección? move_valid?
		operation: new_position [1+1,4+1] - present_position [4+1,0+1] ej. [7,5]-[7,8]=[0,-3]  
			if position[0] is "+" || > 0 = down_vertical
			if position[1] is "+" || > 0 = drch_horizontal
			if position[0] is "-" || < 0 = up_vertical
			if position[1] is "-" || < 0 = izq-horizontal
			if position[index] = 0 > no hay movimiento en ese eje
		filtro por index:
			si cambia sólo un index es mov vertical u horizontal
			si cambian los dos index es mov diagonal ej: torre sólo puede cambiar un index por mov
		usar estos numeros positivos y negativos como filtro previo a movs válidos
			ej: peon colour :white is position[0] "-"(mirasigno) && límite(miracantidad) 1horizontal|2vertical
		declarar mov inválidos if position[x] es +-(el valor de filtro puede almacenarse como @var)

		@@obstaculo? new_position id == samecolour >> return false

		mover
			movs generate
				iteration simple
					iteration vertical -> position = piece.position[0] (subir-bajar+) 1(límite_movs rey1&peones2)
					iteration horizontal -> position = piece.position[1] (izq-drch+) 1(límite_movs rey1&peones2)
				doble iteration
					vertical_horizontal diagonal -> doble up-down/izq-drch *up-izqu=[-=1][-=1](same) down-drch[+=1][+=1] 1(límite_movs rey1&peones1|2)	
				salto_caballo = eje+-2 + otroeje+-1

		iteración
			caballo, no iterar movimientos prueba sólo la new_position
				vacio?true
				@@obstaculo? añadir return false
				enemigo?true
			range_coordenates[0] 0..7
				position[0] sisemuevearriba: restar<=piece.position[0]..7 sisemueveabajo: restar>=0..piece.position[0])
				position[1] sisemueveizquierda: restar<=piece.position[0]..7 sisemuevederecha: restar>=0..piece.position[0])
			iterar por todas las positions
				vacio?continua>true
				@@obstaculo? añadir return false
				enemigo?true
			return true al final
			
		
	end

	def bishop(piece,new_position)

	end

	def rook(piece,new_position)

	end

	def queen(piece,new_position) 

	end

	def king(piece,new_position)
		
	end
#=end
end

class Piece

	def initialize(name,colour_and_piece_id,position=nil)
		@name = name
		@id = colour_and_piece_id
		if @id =~ /^w/
			@colour = :white
		else
			@colour = :black
		end
		@position = position
	end

end

class PieceIA
	include Movements
	attr_reader(:pieces_ids, :id_to_names)

	def initialize
		@pieces_ids = []
		@id_to_names = []
		@colurs = %w{w b}
		@pieces = %w{P B R Q K N}
		@names = %w{pawn bishop rook queen king}
		@name_plus = "knight" #uso diferente, no dinámico, pq knight comparte la inicial K con king
		@range_coordenates = 0..7
		create_pieces_id
		link_id_to_names		
	end

	def check_move?(present_position,new_position,board)
		if present_position == nil || new_position == nil
			return false
		else
			board = @board
			id = content(present_position) 
			name = whatsmyname?(id)
			piece = Piece.new(name,id,present_position)
			self.name(piece,new_position)
		end
	end

private

	#método q permite crear automáticamente las id de piezas de ajedrez, útiles para iteraciones
	def create_pieces_id
		@colours.each do |colour|
			@pieces.each {|piece| @pieces_ids << colour+piece}
		end
	end

	#crea diccionario {id ==> nombre de pieza}, útil para iteraciones a través del valor "name"
	def link_id_to_names
		@names.each do |name|
			id_find = @pieces_ids.find {|id| id[1].downcase == name[0]}
			id_to_names << {id => name}
		end
		@colours.each {|colour| @id_to_names << {colour+"N" => @name_plus}}#añadimos el caso especial knight = N
	end

	#la variable "name" automatiza la llamada a los métodos del módulo "movements"
	def whatsmyname?(id)
		name = @id_to_names.find {|hash| hash[id]}
	end

	#
	def content(new_position)
		@board[present_position[0]][present_position[1]]	
	end

end

class Chess
	attr_reader(:board)
	
	def initialize
		@board = []
		@islegal = []
	end

	def load_board(file_name)
		@board = process_file(file_name)
	end

	def load_moves(file_name)
		movements = process_file(file_name)
		piece_ia = PieceIA.new
		movements.each do |line|
			present_position = translate_coordenate(line[0])
			new_position = translate_coordenate(line[1])
			@islegal << piece_ia.check_move?(present_position,new_position,@board)
		end
	end

	def show_board(board=@board)
		puts process_data(board)		
	end

	def show_movements_are_legal?
		if @islegal	== false
			puts "ILLEGAL"
		else
			puts "LEGAL"
		end
	end

private
	#saca los datos de los archivos
	def process_file(file_name)
		file = IO.read(file_name)
		rows = file.split("\n")
		rows_and_colums = rows.map {|line| line.split(" ")}
	end

	def process_data(data)
		data.map {|line| line.join(" ")}
	end

	def translate_coordenate(coordenate)
		letter_coordenates = "a".."h"
		letter_to_number = letter_coordenates.to_a.index(coordenate[0])
		number_procesed = 8 - coordenate[1]
		#por si nos pasan coordenadas q no se ajustan al tamaño del tablero
		if letter_to_number == nil || (number_procesed < 0 || coordenate[1] <= 0) 
			return nil
		else
			coordenates = [number_procesed,letter_to_number]
		end
	end

end

chess = Chess.new
chess.load_board("chessboard.txt")
puts chess.show_board
=begin
chess.load_moves("moveschess.txt")
chess.show_movements_are_legal?
=end
binding.pry
