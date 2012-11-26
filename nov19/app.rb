require 'sinatra'

# Goals today:
# - Explain the flow from browser to server and back again
# - What is ruby syntax
# - making your own variables
# - Reviewing Week 2

# Main route  - this is the form is shown
get '/' do
  the_time = Time.now
  the_time_as_a_string = the_time.to_s
  @title = "Welcome to my new website, the time is " + the_time_as_a_string
  erb :form
end

# Second route  - this is the form is posted to
get '/hello' do
  # params[:yourname] will be replaced with the value entered for
  # the input with name 'yourname'
  # "Hello " + params[:yourname] + " " + params[:dessert] + " " + params[:blog_post] + " " + params[:day_of_week]
  erb :hello
end

post '/hi' do
  # raise request.inspect
  # params[:yourname] will be replaced with the value entered for
  # the input with name 'yourname'
  # "Hello " + params[:yourname] + " " + params[:dessert] + " " + params[:blog_post] + " " + params[:day_of_week]
  erb :hello
end
