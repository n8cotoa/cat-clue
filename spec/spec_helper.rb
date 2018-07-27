ENV['RACK_ENV'] = 'test'

require("bundler/setup")
Bundler.require(:default, :test)
set(:root, Dir.pwd())

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }

require('capybara/rspec')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)
require('./app')

RSpec.configure do |config|
  config.after(:each) do
    Player.all.each do |player|
      player.destroy
    end
    test_players = ['Player 1', 'Player 2', 'Player 3', 'Player 4']
    test_players.each do |player|
      Player.create({:name => player})
      Player.first.update({:turn => 't'})
    end
    Card.all.each do |card|
      card.update({:answer => 'f', :player_id => nil})
    end
    Space.all.each do |space|
      space.update({:player_id => nil})
    end
    #assign players to set spaces
    player1 = Player.find_by(name: 'Player 1')
    player2 = Player.find_by(name: 'Player 2')
    player3 = Player.find_by(name: 'Player 3')
    player4 = Player.find_by(name: 'Player 4')
    player1_start = Space.find_by(coordinates: 'H1')
    player2_start = Space.find_by(coordinates: 'A3')
    player3_start = Space.find_by(coordinates: 'C10')
    player4_start = Space.find_by(coordinates: 'J7')
    player1_start.update(player_id: player1.id)
    player2_start.update(player_id: player2.id)
    player3_start.update(player_id: player3.id)
    player4_start.update(player_id: player4.id)
  end
end
