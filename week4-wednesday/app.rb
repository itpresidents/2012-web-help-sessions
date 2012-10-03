require 'sinatra'
require 'dm-core'

DataMapper::setup(:default, {:adapter => 'yaml', :path => 'db'})

class BlogPost
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :body, Text
  property :created_at, DateTime
end

DataMapper.finalize

before do
  @title = "Steve's Blog"
end

get '/' do
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

  new_post.created_at = DateTime.now

  if(new_post.save)
    @message = "Post saved successfully."
  else
    @message = "Something went terribly, terribly wrong."
  end

  erb :save_blog
end
