require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
require 'pry'

get('/') do
  @spaces = Space.all
  @player = Player.all.where(turn: 't').first
  erb(:board)
end

get('/board/:coordinates') do
  redirect '/'
end

post '/players/<%= @player.id %>/roll' do
  
end
