require "rspec"

require_relative "../lib/post.rb"

RSpec.describe "Post" do 

	let (:post_instance_correct) {Post.new("Title","Text","Raul")}

	describe "Make a post" do
		
		it "return creation time's post" do
			expect(post_instance_correct.date.class).to be(Time.new.class)
		end

		it "return title's post" do
			expect(post_instance_correct.title).to eq("Title")
		end

		it "return text's post" do
			expect(post_instance_correct.text).to eq("Text")
		end

		it "return category post" do
			expect(post_instance_correct.category).to eq("Main")
		end

		it "return author post" do
			expect(post_instance_correct.author).to eq("Raul")
		end		
	end



end