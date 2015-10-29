require "pry"
require "colorize"

class Blog
	attr_accessor(:symb_title, :symb_text)

	def initialize
		@posts = []
		@posts_cache = []
		@titles = []
		@texts = []
		@symb_title = "**************"
		@symb_text = "---------------"
		@index_post = 0
		@number_pages = 0
		@final_page = 0
	end

	def add_post(post)
		@posts << 	post
	end

	def create_subarray_with_var(option)
		i = 0
		if option == 1
			while i < @posts_cache.length
				@titles << @posts_cache[i].title
				i += 1
			end
		elsif option == 2
			while i < @posts_cache.length
				@texts << @posts_cache[i].text
				i += 1
			end
		end
	end

	def set_sponsored_post(number_post)
		number_post_fixed = number_post - 1
		@titles[number_post_fixed] = "******#{@titles[number_post_fixed]}******"
	end

	def create_front_page
		#sort_by date newest
		@posts_cache = @posts.sort {|post1, post2| post2.date <=> post1.date}
		#crear sub arrays title y text
		create_subarray_with_var(1)#option 1 = title var
		create_subarray_with_var(2)#option 2 = text var
		#cambiar titulo + index, post + index
		@titles.each_with_index {|title, index| @titles[index] = "Post title #{index+1}"}
		@texts.each_with_index {|text, index|  @texts[index] = "Post #{index+1} text"}
		set_sponsored_post(2)
		create_number_of_pages(3)
	end

	def create_number_of_pages(number_post_page)
		final_page = @posts.length / number_post_page
		@final_page = final_page.round + 1
		@number_pages = 1..(@final_page)
	end

	def page_blog(page)
		system("clear")
		while @index_post < 3*page
			puts @titles[@index_post]
			puts @symb_title
			puts @texts[@index_post]
			puts @symb_text
			@index_post += 1
			if @index_post == @posts.length
				@index_post = @posts.length + 1
			end			
		end
		puts "\n\n"
		@number_pages.each do |number|
			if number == page
				print "  #{number}".colorize(:red)
			else 
				print "  #{number}"
			end
		end
		puts "\n"
	end

	def publish_front_page
		self.create_front_page
		page = 1
		while page > 0 && page <= @final_page
			page_blog(page)
			input_nav = gets.chomp
			if input_nav == "next"
				page += 1
			elsif input_nav == "prev"
				page -= 1
				@index_post -= 6
			elsif input_nav == "exit"
				page = 0
			end
		end
	end
end

class Post
	attr_reader(:date, :title, :text)

	def initialize(title,text)
		@title = title
		@date = Time.now
		@text = text
	end

end

blog = Blog.new
8.times do
	blog.add_post(Post.new("Post title", "Post text"))
	sleep 1
end

blog.create_front_page
blog.publish_front_page
