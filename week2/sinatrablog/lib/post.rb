class Post
	attr_reader(:date, :title, :text, :category, :author)

	def initialize(title,text,author,category="Main")
		@title = title
		@text = text
		@author = author
		@category = category
		@date = Time.now#.strftime("%d/%m/%Y - %H:%M:%S")
	end

end