require 'sinatra'

# Main route  - this is the form is shown
get '/' do
  erb(:form)
end


get '/thing/thing/thing/stuff' do
  output = "Title"
  output += "more content"

  output
end

get '/hello' do
  "oh, hi."
end

# Second route  - this is the form is posted to
post '/hello' do

  # params[:yourname] will be replaced with the value entered for
  # the input with name 'yourname'
  # "<h1>Hello " + params[:yourname] + "</h1>"
  erb :form_response
end