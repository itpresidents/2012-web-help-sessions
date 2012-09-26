require 'sinatra'
require 'dm-core'

DataMapper::setup(:default, {:adapter => 'yaml', :path => 'db'})

class Visitor
  include DataMapper::Resource

  property :id,   Serial
  property :name, String
  property :lunch, String
end

class Place
  include DataMapper::Resource

  property :id, Serial
  property :address, String
  property :name, String
end

DataMapper.finalize

get '/' do
  output = <<-HTML
    hi
    there
    how are you
  HTML

  output += <<-HTML
  <form action="http://itp.nyu.edu/~sk3453/sinatra/week3/save_info" method="GET">
    <p><label>First Name:</label> <input type="text" name="fname" /></p>
    <p><label>Last Name:</label> <input type="text" name="lname" /></p>
    <p><input type="submit" value="Go" /></p>
  </form>
  HTML
  output
end

get '/save_info' do
  new_name = params[:fname] + " " + params[:lname]
  counter = 0
  output = ''

  for entry in Visitor.all
    if entry.name == new_name
      counter += 1
    end
  end

  if counter > 0
    output += <<-HTML
    <form action="http://itp.nyu.edu/~sk3453/sinatra/week3/lunch" method="POST">
      <input name="name" value="#{new_name}" type="text"/>
      <p>What did you have for lunch?</p>
      <input name="lunch" type="text"/>
      <input type="submit"/>
    </form>
    HTML
  else
    new_user = Visitor.new
    new_user.name = new_name
    new_user.save
    output += "Welcome #{new_user.name}."
  end

  output
end

get '/all' do
  output = '<h1>All Visitors</h1>'

  for place in Place.all
    output += "<p>#{place.name} #{place.address}</p>"
  end


  for visitor in Visitor.all
    output += "<p>#{visitor.name}</p>"
  end

  output
end