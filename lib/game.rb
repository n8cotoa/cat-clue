class Game < ActiveRecord::Base
  def self.full_reset
    Player.all.each do |player|
      player.destroy
    end
    Card.all.each do |card|
      card.update({:answer => 'f', :player_id => nil})
    end
    Space.where.not(player_id: nil).each do |space|
      space.update({:player_id => nil})
    end
  end

  def self.partial_reset
    Player.all.each do |player|
      player.update({:turn => 'f', :dice_roll => nil, :guess => nil})
    end
    Player.all.first.update({:turn => 't'})
    Card.all.each do |card|
      card.update({:answer => 'f', :player_id => nil})
    end
    Space.where.not(player_id: nil).each do |space|
      space.update({:player_id => nil})
    end
  end
end
