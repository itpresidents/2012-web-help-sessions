require 'sinatra'
require 'dm-core'

DataMapper::setup(:default, {:adapter => 'yaml', :path => 'db'})

# daily icecream order
class Order
  include DataMapper::Resource
  
  property(:id, Serial)
  
  property :persons_name, String
  property :flavor, String
  property :has_sprinkles, Boolean
  property :is_cone, Boolean
  property :scoops, Integer
end

DataMapper.finalize

get '/' do
  erb :form
end

post '/order/new' do
  @old_orders = Order.all(:persons_name => params[:persons_name])
  
  if @old_orders.length == 0
    @new_order = Order.new
    @new_order.persons_name = params[:persons_name]
  else
    @new_order = @old_orders[0]
    @new_order => {persons_name => "Steve", flavor => "chocolatevanilla"}
  end
  
  @new_order.flavor = params[:flavor]
  @new_order.has_sprinkles = params[:has_sprinkles]
  @new_order.is_cone = params[:is_cone]
  @new_order.scoops = params[:scoops]
  
  @new_order.save
  
  erb :order_saved
end

get '/all_orders' do
  @all_orders = Order.all
  erb :all_orders
end

# Get all Orders where has_sprinkles is true
get '/orders/has_sprinkles' do
  @all_orders = Order.all(:has_sprinkles => true)
  erb :all_orders
end

get '/orders/flavor/:flavor' do
  @all_orders = Order.all(:flavor => params[:flavor])
  erb :all_orders
end
