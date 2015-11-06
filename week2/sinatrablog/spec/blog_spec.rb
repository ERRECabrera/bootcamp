require "rspec"

require_relative "../lib/post.rb"
require_relative "../lib/blog.rb"

RSpec.describe "Blog" do 

	let (:instance_post) {Post.new("Title","Text")}

	before(:each) do 
		@instance_blog = Blog.new
	end

	it "return one post added" do
		expect(@instance_blog.add_post(instance_post)).to eq([instance_post])
	end

	it "return all posts added" do
		number_of_post = 3
		number_of_post.times do @instance_blog.add_post(instance_post) end
		expect(@instance_blog.posts.length).to eq(number_of_post)
	end

	it "return the last post in index 0 of posts array" do
		2.times do
			sleep 1
			@instance_blog.add_post(Post.new("Title","Text"))
		end
		@instance_blog.latest_posts
		expect(@instance_blog.posts[0].date.to_i).to be > @instance_blog.posts[1].date.to_i
	end
end