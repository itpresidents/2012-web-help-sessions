require 'sinatra'
require 'dm-core'

DataMapper::setup(:default, {:adapter => 'yaml', :path => 'db'})

class Photo
  include DataMapper::Resource

  property :id, Serial
  property :url, String
end

DataMapper.finalize

# these two lines won't work
@title = "This is a cool website, I think."
@not_on_every_page = "this will not work on any page"

before do
  @oneverypage = "this will work on every page"
end

get "/" do
  @nav = "title"
  erb :form
end

post '/save_image' do
  @nav = "saved"
  @filename = params[:file][:filename]
  file =      params[:file][:tempfile]

  @photo = Photo.new
  @photo.url = "http://itp.nyu.edu/~sk3453/sinatra/dec5/public/" + @filename
  @photo.save

  # Save the image file to the public folder inside this app
  File.open("./public/#{@filename}", 'wb') do |f|
    # for some reason, saving a file in ruby takes 3 lines.
    f.write(file.read)
  end

  erb :show_image
end

get '/pagetwo' do
  @oneverypage = ''
end
