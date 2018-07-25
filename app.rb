require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
require 'pry'

get '/' do
  erb(:splash_page)
end

get '/start' do
  @characters = Card.all.where(card_type: 'Cat')
  erb(:player_form)
end

post '/start/new_players' do
  Game.full_reset #Take this out when deploying application
  player1 = params.fetch('player1')
  player2 = params.fetch('player2')
  player3 = params.fetch('player3')
  player4 = params.fetch('player4')
  Player.create({:name => player1, :turn => 't'})
  Player.create({:name => player2, :turn => 'f'})
  Player.create({:name => player3, :turn => 'f'})
  Player.create({:name => player4, :turn => 'f'})
  Card.murder
  Card.deal_cards
  redirect '/board'
end

get('/board') do
  @spaces = Space.all.order(:id)
  @player = Player.all.where(turn: 't').first
  @cards = Card.all.where(player_id: @player.id)
  erb(:board)
end

get('/board/:coordinates') do
  binding.pry
  current_player = Player.all.where(turn: 't').first
  # current_player.move  Will update players position every click and redirect back to board
  redirect '/board'
end

get '/players/:id/roll' do
  id = params[:id].to_i
  player = Player.find(id)
  player.roll_dice
  redirect back
end

get '/players/:id/checkcards' do
  id = params[:id].to_i
  @player = Player.find(id)
  @player_cards = Card.all.where(player_id: @player.id)
  erb(:checkcards)
end

get '/players/next' do
  #call on the player next
  redirect back
end
