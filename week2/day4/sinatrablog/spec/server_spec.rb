require "rspec"
require "rack/test"

require_relative "../server.rb"

RSpec.describe "Server" do 
	include Rack::Test::Methods #carga métodos para testing en sinatra

	def app
		Sinatra::Application
	end

	it "response in / server folder" do
		get "/"
		expect(last_response).to be_ok
	end

	it "response in /post/post_title" do
		get "/post/title1"
		expect(last_response).to be_ok
	end

	it "response in /new_post" do
		get "/new_post"
		expect(last_response).to be_ok
	end

	it "response post method in /new_post" do
		post "/new_post", :title => nil
		#expect(last_response).to be_ok
	end
end
