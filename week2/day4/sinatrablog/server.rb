require "sinatra"
require "sinatra/reloader" if development?
require "pry"

require_relative "./lib/post.rb"
require_relative "./lib/blog.rb"

user_blog = Blog.new
user = "Raul"
(1..3).each {|n| user_blog.add_post(Post.new("Title #{n}","Text #{n}",user))}

get "/" do 
	user_blog.latest_posts
	@user_blog = user_blog
	erb(:blog)
end

get "/post/:title_id" do
	@post = user_blog.posts.select {|post| post.title.downcase.split(" ").join == params[:title_id]}[0]
	erb(:post)
end

get "/new_post" do 
	erb(:new_post)
end

post "/new_post" do
	user_blog.add_post(Post.new(params[:title],params[:text],params[:author],params[:category]))
	redirect to("/")
end