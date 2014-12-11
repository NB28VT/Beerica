require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require 'dotenv'
require 'httparty'
require 'json'

Dotenv.load
api_key = ENV['MAPBOX_API_ACCESS_TOKEN']
brew_api_key = ENV['BREWERY_DB_API_TOKEN']
beer_map_api = ENV['BEER_MAPPING_TOKEN']



def get_breweries_per_state(state)
  beer_map_api = ENV['BEER_MAPPING_TOKEN']
  beer_map_api_connection = HTTParty.get("http://beermapping.com/webservice/locstate/#{beer_map_api}/#{state}")
  brewery_count = beer_map_api_connection["bmp_locations"].values[0].count
  print "#{state}: #{brewery_count}\n"

end

def get_breweries
  breweries = HTTParty.get("http://api.brewerydb.com/v2/?key=#{brew_api_key}/breweries")
  binding.pry
end





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
  @brew_key = brew_api_key
  binding.pry
  erb :map_test
end


get_breweries_per_state("VT")
get_breweries_per_state("OR")
get_breweries_per_state("CO")
get_breweries_per_state("ME")
get_breweries_per_state("CA")
get_breweries_per_state("NH")
