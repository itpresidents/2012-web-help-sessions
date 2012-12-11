require 'sinatra'
require 'dm-core'

DataMapper::setup(:default, {:adapter => 'yaml', :path => 'db'})

class Post
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :content, Text
  property :mood_image, String
  property :tag_id, Integer

  belongs_to :tag
end

class Tag
  include DataMapper::Resource

  property :id, Serial
  property :title, String

  has n, :posts
end

DataMapper.finalize

# Main route, show all Posts
get '/' do
  @posts = Post.all
  erb :index
end

# HOW TO GET A RANDOM POST
get '/random_post' do
  # Get the total number of Post objects from the database
  number_of_posts = Post.all.length
  # Create a random number between 0 and 1 less than the total number of Posts
  some_random = rand(number_of_posts)

  # Now get all Posts (Post.all) and save the Post in the some_random position
  # to the variable @random_post
  @random_post = Post.all[some_random]

  "<h1>#{@random_post.title}</h1><div>#{@random_post.content}</div>"
end

# HOW TO GET THE N LATEST POSTS
get '/latest_posts' do
  # pick a number of recent posts to retrieve
  n = 3

  # Get all Posts (Post.all) but pass in two conditions to match.
  # First, order the Posts by `id` in a descending order (:id.desc) and then
  # limit the results to the value of n, which we have set above to 3.
  @posts = Post.all(:order => :id.desc, :limit => n)

  # Finally we will use the same index.erb view we use for the index page since
  # @posts is the same variable name.
  erb :index
end

# CREATE A NEW POST
get '/new' do
  # Get all of the Tags from the database so Users can choose one of the tags.
  @tags = Tag.all
  erb :form
end

post '/save' do
  @post = Post.new
  @post.title = params[:title]
  @post.content = params[:content]
  @post.mood_image = params[:mood_image]
  @post.tag_id = params[:tag_id]
  @post.save
  redirect "http://itp.nyu.edu/~sk3453/sinatra/dec10/"
end

# VIEW ALL POSTS BY TAG
get '/tag/:tag_title' do
  # Get the first Tag that matches the title from the URL.
  @tag = Tag.first(:title => params[:tag_title])
  erb :tags
end