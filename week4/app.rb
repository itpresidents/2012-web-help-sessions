require 'sinatra'
require 'dm-core'

DataMapper::setup(:default, {:adapter => 'yaml', :path => 'db'})

class BlogPost
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :body, Text
end

DataMapper.finalize

# Main route  - this is the form where we take the input
get '/' do
  erb :welcome
end

# Show all blog posts
get '/blog' do
  @posts = BlogPost.all
  erb :blog
end

# Form to create a new blog post.
get '/blog/new' do
  erb :blog_new
end

# Save the blog post to Datamapper
post '/blog/save' do
  new_post = BlogPost.new
  new_post.title = params[:title]
  new_post.body = params[:body]

  if(new_post.save)
    @message = "your blog post was saved."
  else
    @message = "there was a problem saving your blog post."
  end

  erb :blog_save
end

get '/about' do
  erb :about
end
