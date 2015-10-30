require "pry"

class Piece

	def initialize(colour_and_piece_id,position=nil)
		@id = colour_and_piece_id
		if @id =~ /^w/
			@colour = :white
		else
			@colour = :black
		end
		@position = position
	end

	def move(position)

	end

end

class Chess
	attr_accessor(:board)
	attr_reader(:pieces_ids, :pieces_object)

	def initialize(file)
		@file = IO.read(file)
		@board = []
		@pieces_ids = []
		@pieces_object = []
	end

	def process_file
		rows = @file.split("\n")
		rows_and_colums = rows.map {|line| line.split(" ")}
		@board << Board.new(rows_and_colums)
	end

	def load_board
		self.process_file
		create_pieces_id
		grid = @board[0].grid
		grid.each_with_index do |row, row_index|
			row.each_with_index do |column, column_index|
				id = grid[row_index][column_index]
				iam?(id,[row_index,column_index])
			end
		end
	end

	def create_pieces_id
		pieces = %w{R N B Q K P}
		colours = %w{w b}
		colours.each do |colour|
			pieces.each {|piece| @pieces_ids << colour+piece}
		end
	end

	def iam?(piece_id,position)
		@pieces_ids.each do |id|
			if piece_id == id
				@pieces_object << Piece.new(id,position)
			end
		end
	end
=begin
	def moves
		new_positions_array << load {present_position, new_position}
		each.find present_position piece_id
		check piece.new_position
		if piece.new_position == true return pieces.new_position && LEGAL
	end
=end
end

class Board
	attr_accessor(:grid)

	def initialize(grid)
		@grid = grid
	end

end

chess = Chess.new("chessboard.txt")
chess.load_board
puts chess.board
binding.pry