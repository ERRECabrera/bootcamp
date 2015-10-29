require 'imdb'
require 'colorize'
require 'pry'

class PruebaImdb
	attr_reader(:movies_graphic)

	def initialize
		@movies_titles = []
		@movies_ratings = []
		@array_films_imdb = []
		@movies_graphic = nil
	end

	def load_imdb_films
		load_titles = IO.read('movie.txt').split("\n")
		load_titles.each do |movie|
			@array_films_imdb << Imdb::Search.new(movie)
		end
	end

	def stage_titles_and_ratings_data
		@array_films_imdb.each do |film|
			request_rating = nil
			request_title = nil
			n = 0
			while request_rating == nil
				request_rating = film.movies[n].rating
				n += 1
			end
			while request_title == nil
				request_title = film.movies[n].title
			end
			@movies_ratings << request_rating.round
			@movies_titles << request_title
		end
	end

	def movie_graphic
		@movies_graphic = Array.new(12){Array.new(7){"| |"}}
		@movies_ratings.each_with_index do |rating, index|
			@movies_graphic[10][index] = "---"
			@movies_graphic[11][index] = "|"+"#{index+1}".colorize(:blue)+"|" 
			array_ratings = 10-rating..9
			array_ratings.each do |number|
				@movies_graphic[number][index] = "|#|"		
			end
		end
	end

	def show_movies_graphic
		movie_graphic
		@movies_graphic.each {|line| puts line.join}
		puts
		@movies_titles.each_with_index do |movie, index|
				puts "#{index+1}.".colorize(:blue) +" #{movie}"
		end
	end
end

my_prueba = PruebaImdb.new
my_prueba.load_imdb_films
my_prueba.stage_titles_and_ratings_data
my_prueba.show_movies_graphic


#binding.pry