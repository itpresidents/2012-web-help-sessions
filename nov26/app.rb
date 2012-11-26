require 'sinatra'
require 'dm-core'

DataMapper::setup(:default, {:adapter => 'yaml', :path => 'db'})

class Person
  include DataMapper::Resource
  
  property(:id, Serial)
  
  property :first_name, String
  property :last_name, String
  property :phone_number, Integer
end

get '/' do
  erb :form
end

post '/newperson' do
  # params = {:first_name => 'steve', :last_name => 'klise', :phone_number => '8675309' }
  
  # @person = Person.new(
  #   :first_name => params[:first_name],
  #   :last_name => params[:last_name],
  #   :phone_number => params[:phone_number]
  # )

  @person = Person.new
  @person.first_name = params[:first_name]
  @person.last_name = params[:last_name]
  @person.phone_number = params[:phone_number]
  
  @person.save
  
  erb :saved
end

get '/allpeople' do
  # get all Person models from the database.
  @people = Person.all
  
  erb :all_people
end
