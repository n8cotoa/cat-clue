require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
require 'sinatra'
require 'sinatra/activerecord'
require './environments'

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
  piece_img = {"Miss Scarlet" => url('../img/pieces/red.png'), "Colonel Mustard" => url('../img/pieces/yellow.png'), "Mr. Green" => url('../img/pieces/green.png'), "Mrs. Peacock" => url('../img/pieces/blue.png'), "Mrs. White" => url('../img/pieces/white.png'), "Professor Plum" => url('../img/pieces/purple.png')}
  new_player1 = Player.new({:name => player1, :turn => 't', :image => piece_img[player1]})
  new_player2 = Player.new({:name => player2, :turn => 'f', :image => piece_img[player2]})
  new_player3 = Player.new({:name => player3, :turn => 'f', :image => piece_img[player3]})
  new_player4 = Player.new({:name => player4, :turn => 'f', :image => piece_img[player4]})
  if (new_player1.save) && (new_player2.save) && (new_player3.save) && (new_player4.save)
    Player.place_player
    Card.murder
    Card.deal_cards
    redirect '/board'
  else
    erb(:errors)
  end
end

get('/board') do
  @spaces = Space.all.order(:id)
  @rooms = ["A1", "A2", "B1", "B2", "A5", "A6", "B5", "B6", "A9", "A10", "B9", "B10", "E1", "E2", "F1", "F2", "E9", "E10", "F9", "F10", "I1", "I2", "J1", "J2", "I5", "I6", "J5", "J6", "I9", "I10", "J9", "J10"]
  @final_room = ["E5", "E6", "F5", "F6"]
  @player = Player.all.where(turn: 't').first
  @cards = Card.all.where(player_id: @player.id)
  erb(:board)
end

get('/board/:coordinates') do
  new_coords = params.fetch('coordinates')
  current_player = Player.all.where(turn: 't').first
  current_player.move(new_coords)
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

get '/players/:id/scorecard' do
  id = params[:id].to_i
  @player = Player.find(id)
  @cards = Card.all
  erb(:scorecard)
end

post '/players/:id/scorecard' do
  @player = Player.find(params.fetch(:id))
  if params.key?('card_ids')
    card_ids = params.fetch("card_ids")
    card_ids.each do |card_id|
      card = Card.find(card_id.to_i)
      @player.cards.push(card)
    end
    redirect back
  else
    redirect back
  end
end

patch '/players/:id/scorecard' do
  @player = Player.find(params.fetch(:id))
  if params.key?('card_ids')
    card_ids = params.fetch("card_ids")
    card_ids.each do |card_id|
      card = Card.find(card_id.to_i)
      @player.cards.destroy(card)
    end
    redirect back
  else
    redirect back
  end
end

get '/players/:id/make_guess' do
  @player = Player.all.where(turn: 't').first
  @room = Space.find_by(player_id: @player)
  @cats = Card.all.where(card_type: 'Cat')
  @weapons = Card.all.where(card_type: 'Weapon')
  erb(:make_guess)
end

get '/players/:id/final_guess' do
  @current_player = Player.all.where(turn: 't').first
  @rooms = Card.all.where(card_type: 'Room')
  @cats = Card.all.where(card_type: 'Cat')
  @weapons = Card.all.where(card_type: 'Weapon')
  erb(:final_guess)
end

post '/players/:id/final_guess' do
  @current_player = Player.all.where(turn: 't').first
  id = params["id"].to_i
  cat = params['killer']
  weapon = params['weapon']
  room = params['room']
  if @current_player.final_guess(cat, weapon, room)
    erb(:win)
  else
    @current_player.end_turn
    player_to_destory = Player.find_by(name: @current_player.name)
    space_update = Space.find_by(player_id: id)
    space_update.update({:player_id => nil})
    player_to_destory.destroy
    erb(:lose)
  end
end

post '/players/:id/make_guess' do
  @player = Player.all.where(turn: 't').first
  @weapon = params['weapon']
  @cat = params['killer']
  @room = params['room']
  @response_from_user = @player.player_guess_match(@cat, @weapon, @room)
  @found_card = Card.find_by(card_name: @response_from_user)
  erb(:guess_result)
end

get '/players/next' do
  current_player = Player.all.where(turn: 't').first
  current_player.end_turn
  redirect '/board'
end
