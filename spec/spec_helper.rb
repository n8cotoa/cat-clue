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
    test_players = ['Player1', 'Player2', 'Player3', 'Player4']
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
  end
end
