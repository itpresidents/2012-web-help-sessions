require 'sinatra'
require 'dm-core'

DataMapper::setup(:default, {:adapter => 'yaml', :path => 'db'})

class Post
  include DataMapper::Resource
  
  property :id, Serial
  property :title, String
  property :content, Text
  property :category, String
end

DataMapper.finalize

get "/" do
  @posts = Post.all
  erb :all_posts
end

get "/posts/new" do
  erb :form
end

post "/posts/save" do
  @post = Post.new()
  @post.title = params[:title]
  @post.content = params[:content]
  @post.category = params[:category]
  @post.save
  
  erb :saved
end














