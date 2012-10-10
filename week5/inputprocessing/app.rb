require 'sinatra'
require 'dm-core'

DataMapper::setup(:default, {:adapter => 'yaml', :path => 'db'})

class BlogPost
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :body, Text
  property :color, String
  # This property is called "created_at" and we will store
  # the current date and time here when we create a new blog post.
  property :created_at, DateTime
end

DataMapper.finalize

# The "before do ... end" block is a special block for Sinatra.
# All code inside this block will be run before every one of the
# routes. We are using it here to define the "@title" the same for
# every route.
before do
  @title = "Steve's Blog"
end

get '/' do
  # Here we are setting a new value for "@title"
  @title = "Welcome to Steve's Blog"

  @posts = BlogPost.all

  erb :index
end

get '/blog/new' do
  erb :new_blog
end

post '/blog/save' do
  new_post = BlogPost.new
  new_post.title = params[:title]
  new_post.body = params[:body]
  new_post.color = params[:color]

  # Set new_post.created_at to the current date and time.
  # "DateTime.now" is a function in Ruby to get the current
  # time on the server and return it as a DateTime object.
  new_post.created_at = DateTime.now

  if(new_post.save)
    @message = "Post saved successfully."
  else
    @message = "Something went terribly, terribly wrong."
  end

  erb :save_blog
end

get '/blog/post/:id' do
  @post = BlogPost.get(params[:id])
  erb :one_post
end






