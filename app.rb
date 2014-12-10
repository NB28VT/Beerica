require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require 'dotenv'

Dotenv.load
api_key = ENV['MAPBOX_API_ACCESS_TOKEN']

configure :development, :test do
  require 'pry'
end

configure do
  set :views, 'app/views'
end

Dir[File.join(File.dirname(__FILE__), 'app', '**', '*.rb')].each do |file|
  require file
  also_reload file
end

get '/map_test' do
  @api_key = api_key
  erb :map_test
end
